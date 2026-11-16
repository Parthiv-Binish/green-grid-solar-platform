# Solar generation estimator

## Purpose
A public educational tool that lets a visitor explore the relationship between entered monthly electricity use, nominal system size, peak sun hours, a user-adjusted performance factor and electricity rate.

## Formula
- Monthly generation = system kW × peak sun hours/day × 30 × performance factor.
- Generation matched to entered use = min(monthly generation, entered monthly kWh).
- Usage coverage = matched generation / entered monthly kWh, capped at 100%.
- Illustrative bill value = matched generation × entered ₹/kWh.

All starting values are editable examples, not Green Grid performance assumptions or a recommendation.

## Limitations shown to users
The model does not simulate hourly load and generation, export credit, net metering, fixed charges, tariff slabs, seasonal irradiance, shading, degradation, battery conversion losses, equipment constraints or local utility rules. Bill value is not actual bill savings. It must not be used as a quotation, engineering design, subsidy calculation or guaranteed financial return.

## Future engineering
A later version may use location-specific irradiance datasets and validated load profiles. Any such model requires documented sources, uncertainty ranges, date/versioned assumptions and review by a qualified solar designer before customer-facing financial claims.
