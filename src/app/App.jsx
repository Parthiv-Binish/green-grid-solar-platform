import { Route, Routes } from 'react-router-dom';
import SiteLayout from '../layouts/SiteLayout.jsx';
import HomePage from '../features/marketing/pages/HomePage.jsx';
import SolutionsPage from '../features/marketing/pages/SolutionsPage.jsx';
import AboutPage from '../features/marketing/pages/AboutPage.jsx';
import ContactPage from '../features/marketing/pages/ContactPage.jsx';
import NotFoundPage from '../features/marketing/pages/NotFoundPage.jsx';
export default function App(){return <Routes><Route element={<SiteLayout/>}><Route path="/" element={<HomePage/>}/><Route path="/solutions" element={<SolutionsPage/>}/><Route path="/about" element={<AboutPage/>}/><Route path="/contact" element={<ContactPage/>}/><Route path="*" element={<NotFoundPage/>}/></Route></Routes>;}