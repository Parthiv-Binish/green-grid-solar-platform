import { useMemo, useState } from 'react';
import { ArrowUpRight, Calculator, Info, RotateCcw } from 'lucide-react';
import { Link } from 'react-router-dom';
import './solar-calculator.scss';

const defaults = { monthlyUsage: 450, systemSize: 3, sunHours: 4.5, performance: 80, tariff: 6.5 };
const number = value => Number.isFinite(Number(value)) ? Number(value) : 0;
const format = value => new Intl.NumberFormat('en-IN', { maximumFractionDigits: 0 }).format(value);

export default function SolarCalculatorPage() {
  const [values, setValues] = useState(defaults);
  const update = (key, value) => setValues(current => ({ ...current, [key]: value }));
  const estimate = useMemo(() => {
    const generation = number(values.systemSize) * number(values.sunHours) * 30 * number(values.performance) / 100;
    const usage = number(values.monthlyUsage);
    const offset = Math.min(generation, usage);
    return { generation, offset, coverage: usage > 0 ? Math.min(100, offset / usage * 100) : 0, billValue: offset * number(values.tariff) };
  }, [values]);
  const reset = () => setValues(defaults);
  return <section className="section calculator-page"><div className="container">
    <div className="calculator-heading"><span className="eyebrow">PLANNING TOOL</span><h1>Explore what solar<br/>could generate.</h1><p>Use your own figures to explore a simple energy estimate. This is an educational calculation, not a system design, savings promise or quotation.</p></div>
    <div className="calculator-layout"><form className="calculator-form" onSubmit={event => event.preventDefault()}>
      <div className="calculator-form-head"><div><span className="calculator-kicker">YOUR STARTING POINT</span><h2>Adjust the assumptions</h2></div><button type="button" className="reset-button" onClick={reset}><RotateCcw size={15}/> Reset</button></div>
      <label className="calc-field"><span>Monthly electricity use <small>kWh per month</small></span><input type="number" min="1" max="100000" step="1" value={values.monthlyUsage} onChange={e => update('monthlyUsage', e.target.value)}/></label>
      <label className="calc-field"><span>Solar system size <small>kW</small></span><input type="number" min="0.1" max="1000" step="0.1" value={values.systemSize} onChange={e => update('systemSize', e.target.value)}/></label>
      <label className="calc-field"><span>Peak sun hours <small>hours per day</small></span><input type="number" min="0" max="12" step="0.1" value={values.sunHours} onChange={e => update('sunHours', e.target.value)}/></label>
      <label className="calc-field"><span>System performance <small>% (loss allowance)</small></span><input type="number" min="1" max="100" step="1" value={values.performance} onChange={e => update('performance', e.target.value)}/></label>
      <label className="calc-field"><span>Electricity rate <small>₹ per kWh</small></span><input type="number" min="0" max="1000" step="0.01" value={values.tariff} onChange={e => update('tariff', e.target.value)}/></label>
      <p className="calculator-help"><Info size={16}/> Replace every starting value with information from your own electricity bill and a site-specific solar assessment.</p>
    </form>
    <section className="calculator-results" aria-live="polite"><span className="calculator-kicker">ILLUSTRATIVE OUTPUT</span><h2>Your estimated solar generation</h2><div className="generation-number"><strong>{format(estimate.generation)}</strong><span>kWh / month</span></div><div className="coverage-track" role="img" aria-label={`Estimated generation covers ${estimate.coverage.toFixed(0)} percent of entered monthly electricity use`}><span style={{ width: `${estimate.coverage}%` }}/></div><div className="result-line"><span>Estimated usage coverage</span><strong>{estimate.coverage.toFixed(0)}%</strong></div><div className="result-line"><span>Generation matched to usage</span><strong>{format(estimate.offset)} kWh</strong></div><div className="result-line"><span>Illustrative bill value of matched energy</span><strong>₹{format(estimate.billValue)}</strong></div><p className="result-disclaimer">This simple model assumes 30 days per month and applies one performance factor. It does not model hourly self-consumption, export credits, net metering, fixed charges, seasonal weather, shading, degradation, battery losses or tariff slabs. The bill-value figure is not a forecast of your actual bill reduction.</p><Link className="button button-lime" to="/contact">Discuss a site assessment <ArrowUpRight size={17}/></Link></section></div>
    <div className="calculator-footnote"><Calculator size={18}/><p><strong>Why a site assessment matters</strong><br/>Roof orientation, shading, structure, sanctioned load, electrical configuration and applicable utility rules can change the system that is technically and commercially suitable.</p></div>
  </div></section>;
}
