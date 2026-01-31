import { pool } from "@/lib/db";

type TeamPerformanceRow = {
  equipo: string;
  partidos_jugados: number;
  goles_a_favor: number;
  goles_en_contra: number;
  diferencia_goles: number;
};

export default async function Report1() {
  const result = await pool.query<TeamPerformanceRow>(`
    SELECT equipo, partidos_jugados, goles_a_favor, goles_en_contra, diferencia_goles
    FROM view_team_performance
    ORDER BY diferencia_goles DESC
  `);

  return (
    <main className="p-8">
      <h1 className="text-2xl font-bold mb-2">Rendimiento por equipo</h1>
      <p className="mb-4 text-gray-600">
        Este reporte muestra el desempeño general de cada equipo en la fase de grupos:
        partidos jugados, goles a favor, en contra y diferencia de goles.
      </p>

      <table className="border w-full text-sm">
        <thead>
          <tr className="bg-gray-100">
            <th className="border p-2">Equipo</th>
            <th className="border p-2">PJ</th>
            <th className="border p-2">GF</th>
            <th className="border p-2">GC</th>
            <th className="border p-2">DG</th>
          </tr>
        </thead>
        <tbody>
          {result.rows.map((row: TeamPerformanceRow) => (
            <tr key={row.equipo}>
              <td className="border p-2">{row.equipo}</td>
              <td className="border p-2">{row.partidos_jugados}</td>
              <td className="border p-2">{row.goles_a_favor}</td>
              <td className="border p-2">{row.goles_en_contra}</td>
              <td className="border p-2">{row.diferencia_goles}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </main>
  );
}


