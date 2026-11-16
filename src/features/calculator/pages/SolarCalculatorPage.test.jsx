import { describe, expect, it } from 'vitest';
import { renderToStaticMarkup } from 'react-dom/server';
import { MemoryRouter } from 'react-router-dom';
import SolarCalculatorPage from './SolarCalculatorPage.jsx';

describe('SolarCalculatorPage', () => {
  it('explains the estimate and renders editable starting assumptions', () => {
    const html = renderToStaticMarkup(<MemoryRouter><SolarCalculatorPage /></MemoryRouter>);
    expect(html).toContain('Peak sun hours');
    expect(html).toContain('not a forecast of your actual bill reduction');
    expect(html).toContain('Discuss a site assessment');
  });
});
