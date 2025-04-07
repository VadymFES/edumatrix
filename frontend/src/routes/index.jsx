import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Navbar from '../components/common/Navbar';
import Dashboard from '../components/dashboard/Dashboard';
import KnowledgeMap from '../components/knowledge-map/KnowledgeMap';
import Login from '../components/auth/Login';
import Register from '../components/auth/Register';
import ConceptView from '../components/concept/ConceptView';

const AppRoutes = () => {
  const isAuthenticated = Boolean(localStorage.getItem('token'));
  
  return (
    <Router>
      <Navbar />
      <Routes>
        <Route 
          path="/" 
          element={isAuthenticated ? <Navigate to="/dashboard" /> : <Navigate to="/login" />} 
        />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route 
          path="/dashboard" 
          element={isAuthenticated ? <Dashboard /> : <Navigate to="/login" />} 
        />
        <Route 
          path="/knowledge-map" 
          element={isAuthenticated ? <KnowledgeMap /> : <Navigate to="/login" />} 
        />
        <Route 
          path="/concept/:conceptId" 
          element={isAuthenticated ? <ConceptView /> : <Navigate to="/login" />} 
        />
      </Routes>
    </Router>
  );
};

export default AppRoutes;