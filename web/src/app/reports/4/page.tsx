import { pool } from "@/lib/db";

type PlayersByPositionRow = {
  posicion: string;
  total_jugadores: number;
};

export default async function Report4() {
  const result = await pool.query<PlayersByPositionRow>(`
    SELECT posicion, total_jugadores
    FROM view_players_by_position
    ORDER BY total_jugadores DESC
  `);

  const total = result.rows.reduce(
    (sum, row) => sum + row.total_jugadores,
    0
  );

  return (
    <main className="p-8">
      <h1 className="text-2xl font-bold mb-2">Jugadores por posición</h1>

      <p className="mb-4 text-gray-600">
        Este reporte agrupa a los jugadores según su posición en el campo y
        muestra cuántos existen en cada categoría.
      </p>

      <div className="mb-4 p-4 bg-gray-100 rounded">
        <strong>Total de jugadores:</strong> {total}
      </div>

      <table className="border w-full text-sm">
        <thead>
          <tr className="bg-gray-100">
            <th className="border p-2">Posición</th>
            <th className="border p-2">Cantidad</th>
          </tr>
        </thead>

        <tbody>
          {result.rows.map((row) => (
            <tr key={row.posicion}>
              <td className="border p-2">{row.posicion}</td>
              <td className="border p-2 text-center">
                {row.total_jugadores}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </main>
  );
}
