import { describe, expect, it } from 'vitest';
import { renderToStaticMarkup } from 'react-dom/server';
import { MemoryRouter } from 'react-router-dom';
import React from 'react';
import HomePage from './HomePage.jsx';

describe('HomePage', () => {
  it('explains the service and exposes an assessment action', () => {
    const html = renderToStaticMarkup(<MemoryRouter><HomePage /></MemoryRouter>);
    expect(html).toContain('Make your roof work');
    expect(html).toContain('Request a site assessment');
    expect(html).toContain('Solar for your home');
  });
});
