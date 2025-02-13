import React, { useState } from 'react';
import './App.css';

function App() {
  const [alertText, setAlertText] = useState('');
  const [response, setResponse] = useState(null);
  const [loading, setLoading] = useState(false);

  // Function to send an alert to the backend
  const sendAlert = async () => {
    if (!alertText) return;
    setLoading(true);
    try {
      const res = await fetch('http://localhost:8000/alert', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ event: alertText })
      });
      const data = await res.json();
      setResponse(data);
      setAlertText('');
    } catch (error) {
      console.error('Error sending alert:', error);
      setResponse({ error: 'Failed to send alert' });
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={{ margin: '20px', fontFamily: 'Arial, sans-serif' }}>
      <h1>Weather Alert Demo</h1>
      <div style={{ marginBottom: '10px' }}>
        <input
          type="text"
          placeholder="Enter alert event (e.g., Tornado Warning)"
          value={alertText}
          onChange={(e) => setAlertText(e.target.value)}
          style={{
            padding: '8px',
            width: '300px',
            border: '1px solid #ccc',
            borderRadius: '4px'
          }}
        />
        <button
          onClick={sendAlert}
          disabled={loading}
          style={{
            marginLeft: '10px',
            padding: '8px 12px',
            border: 'none',
            borderRadius: '4px',
            backgroundColor: '#0070f3',
            color: 'white',
            cursor: 'pointer'
          }}
        >
          {loading ? 'Sending...' : 'Send Alert'}
        </button>
      </div>
      {response && (
        <div style={{ marginTop: '20px', padding: '10px', border: '1px solid #ccc', borderRadius: '4px', backgroundColor: '#f9f9f9' }}>
          <strong>Response:</strong>
          <pre>{JSON.stringify(response, null, 2)}</pre>
        </div>
      )}
    </div>
  );
}

export default App;
