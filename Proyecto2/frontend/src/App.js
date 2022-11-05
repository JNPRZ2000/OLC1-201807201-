import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom'
import Index from './pages/Index';
import './App.css';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Index />} />
        <Route path='*' element={<Navigate to="/" replace={true} />} exact={true} />
      </Routes>
    </BrowserRouter>
  );
}
/*function Page() {
  return (
    <div className="App">
      <header className="App-header">
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}*/
export default App;
