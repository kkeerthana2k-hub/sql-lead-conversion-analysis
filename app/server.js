const express = require('express');
const path = require('path');
const { Pool } = require('pg');

const app = express();
const port = process.env.PORT || 3000;

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 5432,
  database: process.env.DB_NAME || 'crew',
  user: process.env.DB_USER || 'crew',
  password: process.env.DB_PASSWORD || 'crewpass',
});

app.use(express.static(path.join(__dirname, 'public')));

const TABLES = [
  { name: 'campaign', label: 'Campaigns', description: 'Marketing campaigns with cost, ad, and platform' },
  { name: 'sales', label: 'Sales Reps', description: 'Sales representatives' },
  { name: 'lead', label: 'Leads', description: 'Leads generated from campaigns' },
  { name: 'trial_appointment', label: 'Trial Appointments', description: 'Trial appointments for leads' },
  { name: 'client', label: 'Clients', description: 'Converted leads who became clients' },
  { name: 'membership', label: 'Memberships', description: 'Membership details for clients' },
];

const QUERIES = [
  {
    id: 'q1',
    title: 'Female Analysts & IT Managers with Memberships',
    description: 'Find female leads who are analysts or IT managers and their membership details',
    sql: `SELECT lead.name, client.profession, membership.member_id, client.blood_grp, UPPER(client.gender) AS gender
          FROM lead
          INNER JOIN client ON lead.lead_id = client.lead_id
          INNER JOIN membership ON client.client_id = membership.client_id
          WHERE gender = 'female' AND profession = 'Analyst'
             OR gender = 'female' AND lower(profession) LIKE '%it manager%'`
  },
  {
    id: 'q2',
    title: 'Campaigns With No Leads (Wasted Marketing)',
    description: 'Find campaigns that generated zero leads',
    sql: `SELECT c.campaign_id, c.platform, c.cost, l.lead_id
          FROM lead l
          RIGHT OUTER JOIN campaign c ON l.campaign_id = c.campaign_id
          WHERE l.lead_id IS NULL`
  },
  {
    id: 'q3',
    title: 'Leads Who Attended Trial AND Became Clients',
    description: 'Lead IDs that appear in both trial appointments and clients (INTERSECT)',
    sql: `SELECT lead_id FROM trial_appointment
          INTERSECT
          SELECT lead_id FROM client`
  },
  {
    id: 'q4',
    title: 'Clients Born Before 1990',
    description: 'Clients born before January 1, 1990 (EXCEPT set operator)',
    sql: `SELECT * FROM client
          EXCEPT
          SELECT * FROM client WHERE dob >= '1990-01-01'::DATE`
  },
  {
    id: 'q5',
    title: 'Expensive Campaigns With Few Leads',
    description: 'Campaigns costing more than 1200 with fewer than 2 leads',
    sql: `SELECT count(lead_id) AS total_leads, lead.campaign_id, cost, platform
          FROM lead
          INNER JOIN campaign ON lead.campaign_id = campaign.campaign_id
          WHERE cost > 1200
          GROUP BY lead.campaign_id, cost, platform
          HAVING count(lead_id) < 2
          ORDER BY count(lead_id)`
  },
  {
    id: 'q6',
    title: 'Platform Lead Generation Trends',
    description: 'Number of leads generated per platform (platforms with more than 3 leads)',
    sql: `SELECT count(lead_id) AS total_leads, platform
          FROM lead
          INNER JOIN campaign ON lead.campaign_id = campaign.campaign_id
          GROUP BY platform
          HAVING count(lead_id) > 3
          ORDER BY count(platform) DESC`
  },
  {
    id: 'q7',
    title: 'In-Progress Leads for Reps with 5+ Assignments',
    description: 'Leads with in-progress follow-up assigned to reps handling more than 5 leads (subquery)',
    sql: `SELECT *
          FROM lead
          WHERE UPPER(followup_status) = 'IN PROGRESS'
            AND rep_id IN (
              SELECT rep_id FROM lead
              GROUP BY rep_id
              HAVING COUNT(lead_id) > 5
            )`
  },
];

app.get('/api/tables', (req, res) => {
  res.json(TABLES);
});

app.get('/api/queries', (req, res) => {
  res.json(QUERIES.map(q => ({ id: q.id, title: q.title, description: q.description })));
});

app.get('/api/table/:name', async (req, res) => {
  const tableName = req.params.name;
  if (!TABLES.find(t => t.name === tableName)) {
    return res.status(404).json({ error: 'Table not found' });
  }
  try {
    const result = await pool.query(`SELECT * FROM ${tableName} ORDER BY 1`);
    res.json({ columns: result.fields.map(f => f.name), rows: result.rows });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.get('/api/query/:id', async (req, res) => {
  const query = QUERIES.find(q => q.id === req.params.id);
  if (!query) {
    return res.status(404).json({ error: 'Query not found' });
  }
  try {
    const result = await pool.query(query.sql);
    res.json({ columns: result.fields.map(f => f.name), rows: result.rows, title: query.title, description: query.description });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.get('/api/health', async (req, res) => {
  try {
    await pool.query('SELECT 1');
    res.json({ status: 'ok' });
  } catch (err) {
    res.status(500).json({ status: 'error', message: err.message });
  }
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Crew DB Viewer running on port ${port}`);
});
