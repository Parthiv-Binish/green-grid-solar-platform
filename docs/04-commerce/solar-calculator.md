# Solar Calculator Requirements

## 1. Purpose

Provide an indicative educational estimate and generate a qualified lead. It is not an engineering design, utility bill prediction, subsidy approval or guaranteed financial return.

## 2. Inputs

Minimum:
- State / location or PIN code.
- Customer type: residential / commercial.
- Average monthly bill or monthly consumption (kWh).
- Tariff / bill details if known.
- Property type.
- Desired outcome: bill reduction / backup / both.

Optional advanced inputs:
- Upload recent electricity bills.
- Available roof area.
- Roof type and orientation.
- Shading information.
- Daytime versus night-time usage.
- Essential backup loads and desired backup duration.
- Existing solar / inverter / battery equipment.

## 3. Outputs

- Indicative system capacity range.
- Estimated monthly / annual generation range.
- Estimated self-consumption and export assumptions.
- Estimated bill impact range.
- Indicative project cost range, only when approved pricing data exists.
- Subsidy information as a separate conditional estimate.
- Estimated simple payback range with assumptions.
- Key caveats and next steps.
- CTA to request site assessment.

## 4. Calculation principles

- Use location-specific solar resource data from a documented source.
- State the assumed performance ratio / system losses.
- Consider orientation, tilt and shading where data exists.
- Do not equate monthly bill rupees directly to kWh without tariff information.
- Distinguish generated energy, self-consumed energy and exported energy.
- Account for fixed charges and tariff rules where the model supports them.
- Model degradation and tariff escalation only if assumptions are shown.
- Do not promise savings or payback.

## 5. Subsidy handling

Subsidy must be displayed separately and only for eligible customer / system scenarios. The amount, cap, eligibility and process must be verified against current official guidance. Do not silently subtract a subsidy from project price or describe it as an unconditional company discount.

## 6. Validation

- Reject negative or impossible inputs.
- Validate file type and size for uploaded bills.
- Explain optional inputs.
- Show result range, not false precision.
- Label every output “indicative”.
- Record calculator model version and assumptions for each saved lead.

## 7. Acceptance criteria

- A customer can complete the basic calculator on a mobile device.
- Results show assumptions and uncertainty.
- No result is generated from missing required inputs.
- The result can be attached to an enquiry with customer consent.
- Calculator logic is unit-tested using known scenarios reviewed by a technical person.
