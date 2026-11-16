import { Outlet } from 'react-router-dom';
import SiteHeader from '../components/navigation/SiteHeader.jsx';
import SiteFooter from '../components/navigation/SiteFooter.jsx';
export default function SiteLayout(){return <><a className="skip-link" href="#main-content">Skip to content</a><SiteHeader/><main id="main-content"><Outlet/></main><SiteFooter/></>;}