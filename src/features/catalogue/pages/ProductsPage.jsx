import { useEffect, useState } from 'react';
import { ArrowUpRight, Boxes, CircleHelp } from 'lucide-react';
import { Link } from 'react-router-dom';
import { listPublishedProducts } from '../api/catalogueApi.js';

export default function ProductsPage() {
  const [state, setState] = useState({ loading: true, products: [], error: '' });
  useEffect(() => {
    let active = true;
    listPublishedProducts()
      .then(products => { if (active) setState({ loading: false, products, error: '' }); })
      .catch(() => { if (active) setState({ loading: false, products: [], error: 'The product catalogue is temporarily unavailable.' }); });
    return () => { active = false; };
  }, []);

  return <section className="section catalogue-page">
    <div className="container">
      <span className="eyebrow">PRODUCT CATALOGUE</span>
      <h1 className="catalogue-title">Equipment details,<br/>without the guesswork.</h1>
      <p className="catalogue-intro">Compare exact models, specifications and supporting documents before making a decision.</p>
      {state.loading ? <p role="status">Loading the published catalogue…</p> : state.error ? <p role="alert" className="catalogue-notice">{state.error}</p> : state.products.length === 0 ?
        <div className="catalogue-empty">
          <span className="catalogue-empty-icon"><Boxes size={28}/></span>
          <h2>Catalogue is being prepared</h2>
          <p>There are no published products yet. Green Grid administrators will add verified models, specifications, images and datasheets before they appear here.</p>
          <p className="catalogue-note"><CircleHelp size={17}/> We do not display sample products, estimated prices or unverified equipment details.</p>
          <Link className="button button-dark" to="/contact">Ask about your requirements <ArrowUpRight size={17}/></Link>
        </div> :
        <div className="catalogue-grid">{state.products.map(product => <article className="catalogue-card" key={product.id}><img src={product.image_url} alt={product.image_alt || product.name}/><div><h2>{product.name}</h2><p>{product.summary}</p></div></article>)}</div>
      }
    </div>
  </section>;
}
