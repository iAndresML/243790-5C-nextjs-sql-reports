import { pool } from "@/lib/db";

type GoalRankingRow = {
  equipo: string;
  goles_totales: number;
};

export default async function Report2() {
  const result = await pool.query<GoalRankingRow>(`
    SELECT equipo, goles_totales
    FROM view_team_goal_ranking
    ORDER BY goles_totales DESC
  `);

  const totalGoles = result.rows.reduce(
    (sum, row) => sum + row.goles_totales,
    0
  );

  return (
    <main className="p-8">
      <h1 className="text-2xl font-bold mb-2">Ranking de goles por equipo</h1>

      <p className="mb-4 text-gray-600">
        Este reporte muestra qué equipos han marcado más goles durante la fase de grupos.
      </p>

      <div className="mb-4 p-4 bg-gray-100 rounded">
        <strong>Total de goles registrados:</strong> {totalGoles}
      </div>

      <table className="border w-full text-sm">
        <thead>
          <tr className="bg-gray-100">
            <th className="border p-2">Equipo</th>
            <th className="border p-2">Goles</th>
          </tr>
        </thead>

        <tbody>
          {result.rows.map((row) => (
            <tr key={row.equipo}>
              <td className="border p-2">{row.equipo}</td>
              <td className="border p-2 text-center">{row.goles_totales}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </main>
  );
}
