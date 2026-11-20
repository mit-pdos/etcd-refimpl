module

public import Refimpl.github_com.prometheus.client_golang.prometheus.Impl
public import Spec.github_com.prometheus.client_golang.prometheus.ExponentialBuckets
public import Perennial.Golang.Theory.Plain

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI

section proof
variable [GooseExts] [GooseSemantics] [GooseInterp]
variable [go_gctx : GoGlobalContext]
variable {GF : BundledGFunctors} [hG : HeapGS HasLC.hasLC GF]
variable [sem : go.Semantics]
variable [ref : github_com.prometheus.client_golang.prometheus.Refimpl]
variable [package_sem : github_com.prometheus.client_golang.prometheus.Assumptions]

/-- The reference implementation's bucket `i`: `start`'s bits plus `i << 52`. -/
theorem expBucket_bits (start i : w64)
    (hb : uint.nat i * 2 ^ 52 < 2 ^ 64) :
    start + i <<< W64 52 = W64 (uint.Z start + ((sint.nat i : Nat) : Int) * 2 ^ 52) := by
  have h : uint.nat (i <<< W64 52) = uint.nat i * 2 ^ 52 := by
    show (i <<< W64 52).toNat = i.toNat * 2 ^ 52
    rw [BitVec.shiftLeft_eq', BitVec.toNat_shiftLeft]
    have h52 : (W64 52).toNat = 52 := rfl
    rw [h52, Nat.shiftLeft_eq]
    exact Nat.mod_eq_of_lt hb
  word

/-- One more bucket written. -/
theorem expBuckets_set (start : w64) (i n : Nat) (hi : i < n) :
    (prometheus.expBuckets start i ++ List.replicate (n - i) (zero_val w64)).set i
        (W64 (uint.Z start + (i : Int) * 2 ^ 52)) =
      prometheus.expBuckets start (i + 1) ++ List.replicate (n - (i + 1)) (zero_val w64) := by
  have hlen : (prometheus.expBuckets start i).length = i := by simp [prometheus.expBuckets]
  obtain ⟨k, hk⟩ : ∃ k, n - i = k + 1 := ⟨n - i - 1, by omega⟩
  rw [List.set_append_right _ _ (by omega), hlen, Nat.sub_self, hk, List.replicate_succ,
    List.set_cons_zero, show n - (i + 1) = k by omega]
  simp [prometheus.expBuckets, List.range_succ]

/-! The loop's arithmetic, stated apart from the model proof (`omega`'s and `word`'s proofs
inside it failed the kernel's check: auxiliary proofs abstracted with mismatched arguments). -/

theorem expBuckets_len (count : w64) (sl : GoSlice) (Hcount : 1 ≤ sint.Z count)
    (Hlen : sint.nat count = sint.nat sl.len ∧ 0 ≤ sint.Z sl.len) :
    sint.Z sl.len = sint.Z count := by
  obtain ⟨h1, h2⟩ := Hlen; word

theorem expBuckets_init (count : w64) (Hcount : 1 ≤ sint.Z count) :
    0 ≤ sint.Z (W64 0) ∧ sint.Z (W64 0) ≤ sint.Z count := by word

theorem expBuckets_step (start count i : w64) (Hi : 0 ≤ sint.Z i)
    (Hif : sint.Z i < sint.Z count)
    (Hlast : uint.nat start + (sint.Z count).toNat.pred * 2 ^ 52 < 0x7FF0000000000000) :
    uint.nat i * 2 ^ 52 < 2 ^ 64 ∧ sint.nat i < sint.nat count ∧
      sint.Z i < ((sint.nat i + (sint.nat count - sint.nat i) : Nat) : Int) ∧
      sint.nat (i + W64 1) = sint.nat i + 1 ∧
      0 ≤ sint.Z (i + W64 1) ∧ sint.Z (i + W64 1) ≤ sint.Z count := by
  rw [Nat.pred_eq_sub_one] at Hlast
  have hi' : uint.nat i ≤ (sint.Z count).toNat - 1 := by word
  have := Nat.mul_le_mul_right (2 ^ 52) hi'
  refine ⟨by omega, by word, by word, by word, by word, by word⟩

theorem expBuckets_done (count i : w64) (Hi : 0 ≤ sint.Z i ∧ sint.Z i ≤ sint.Z count)
    (Hif : ¬sint.Z i < sint.Z count) : sint.nat i = (sint.Z count).toNat := by word

theorem prometheus.ExponentialBuckets.model_proof :
    model% (EtcdGrove.prometheus.ExponentialBuckets.spec (GF := GF) (hG := hG)) with [] := by
  intro start factor count _ Hargs
  obtain ⟨Hstart, Hcount, Hlast⟩ := Hargs
  wp_start
  wp_auto
  wp_apply (wp_slice_make2 (V := w64) count) $$ [] as %sl ⟨Hsl, Hcap⟩
  · ipureintro; exact Int.le_trans (by decide) Hcount
  ihave %Hlen := ownSlice_len _ _ _ $$ Hsl
  simp only [List.length_replicate] at Hlen
  have Hsllen := expBuckets_len count sl Hcount Hlen
  ihave HI : (∃ (i_val : w64),
      "i" ∷ i_ptr ↦ i_val ∗
      "Hsl" ∷ sl ↦* (prometheus.expBuckets start (sint.nat i_val) ++
        List.replicate (sint.nat count - sint.nat i_val) (zero_val w64)) ∗
      "%Hi" ∷ ⌜0 ≤ sint.Z i_val ∧ sint.Z i_val ≤ sint.Z count⌝ : IProp GF) $$ [i Hsl]
  · iexists (W64 0)
    iframe
    ipureintro; exact expBuckets_init count Hcount
  wp_for HI
  wp_if_destruct
  · have hc : 0 ≤ sint.Z i_val ∧ sint.Z i_val < sint.Z sl.len := ⟨Hi.1, Hsllen ▸ Hif⟩
    simp only [hc, and_self, ↓reduceIte]
    wp_auto
    obtain ⟨hb, hlt, hidx, hsucc, hlo, hhi⟩ := expBuckets_step start count i_val Hi.1 Hif Hlast
    rw [expBucket_bits start i_val hb]
    wp_apply (wp_store_slice_index (t := go.uint64) sl (sint.Z i_val)
      (prometheus.expBuckets start (sint.nat i_val) ++
        List.replicate (sint.nat count - sint.nat i_val) (zero_val w64)) _) $$ [Hsl] as Hsl
    · iframe; ipureintro; simp only [prometheus.expBuckets, List.length_append, List.length_map,
        List.length_range, List.length_replicate]; exact ⟨Hi.1, hidx⟩
    rw [show (sint.Z i_val).toNat = sint.nat i_val from rfl,
      expBuckets_set start (sint.nat i_val) (sint.nat count) hlt]
    wp_for_post
    iframe
    iexists (i_val + W64 1)
    iframe
    rw [hsucc]
    iframe
    ipureintro; exact ⟨hlo, hhi⟩
  · have heq : prometheus.expBuckets start (sint.nat i_val) ++
        List.replicate (sint.nat count - sint.nat i_val) (zero_val w64) =
        prometheus.expBuckets start (sint.Z count).toNat := by
      have h := expBuckets_done count i_val Hi Hif
      rw [h, show sint.nat count = (sint.Z count).toNat from rfl, Nat.sub_self, List.replicate_zero, List.append_nil]
    rw [heq]
    iapply HΦ
    iexact Hsl

end proof

end Model
end EtcdGrove
end Perennial
