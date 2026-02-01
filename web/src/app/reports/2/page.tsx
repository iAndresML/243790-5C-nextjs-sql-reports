import { pool } from "@/lib/db";
import { z } from "zod";

const schema = z.object({
  fase: z.string().optional(),
});

type MatchRow = {
  fase: string;
  total_partidos: number;
  goles_totales: number;
};

export default async function Report2({
  searchParams,
}: {
  searchParams: { fase?: string };
}) {
  const parsed = schema.parse(searchParams);

  const fase = parsed.fase ?? "Fase de Grupos";

  const result = await pool.query<MatchRow>(
    `
    SELECT fase, total_partidos, goles_totales
    FROM view_high_scoring_matches_by_phase
    WHERE fase = $1
  `,
    [fase]
  );

  return (
    <main className="p-8">
      <h1 className="text-2xl font-bold mb-2">Partidos por fase</h1>

      <p className="mb-4 text-gray-600">
        Reporte con filtros validados usando Zod y consultas parametrizadas.
      </p>

      <div className="mb-4 p-4 bg-gray-100 rounded">
        <strong>Fase:</strong> {fase}
      </div>

      <table className="border w-full text-sm">
        <thead>
          <tr className="bg-gray-100">
            <th className="border p-2">Fase</th>
            <th className="border p-2">Partidos</th>
            <th className="border p-2">Goles</th>
          </tr>
        </thead>

        <tbody>
          {result.rows.map((row) => (
            <tr key={row.fase}>
              <td className="border p-2">{row.fase}</td>
              <td className="border p-2">{row.total_partidos}</td>
              <td className="border p-2">{row.goles_totales}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </main>
  );
}
