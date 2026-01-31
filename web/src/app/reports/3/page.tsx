import { pool } from "@/lib/db";

type StadiumUsageRow = {
  estadio: string;
  partidos_jugados: number;
  goles_totales: number;
  promedio_goles: number;
};

export default async function Report3() {
  const result = await pool.query<StadiumUsageRow>(`
    SELECT estadio, partidos_jugados, goles_totales, promedio_goles
    FROM view_stadium_usage
    ORDER BY partidos_jugados DESC
  `);

  const totalPartidos = result.rows.reduce(
    (sum, row) => sum + row.partidos_jugados,
    0
  );

  return (
    <main className="p-8">
      <h1 className="text-2xl font-bold mb-2">Uso de estadios</h1>

      <p className="mb-4 text-gray-600">
        Este reporte muestra cuántos partidos se jugaron en cada estadio y
        cuántos goles se marcaron, junto con el promedio de goles por partido.
      </p>

      <div className="mb-4 p-4 bg-gray-100 rounded">
        <strong>Total de partidos registrados:</strong> {totalPartidos}
      </div>

      <table className="border w-full text-sm">
        <thead>
          <tr className="bg-gray-100">
            <th className="border p-2">Estadio</th>
            <th className="border p-2">Partidos</th>
            <th className="border p-2">Goles</th>
            <th className="border p-2">Promedio</th>
          </tr>
        </thead>

        <tbody>
          {result.rows.map((row) => (
            <tr key={row.estadio}>
              <td className="border p-2">{row.estadio}</td>
              <td className="border p-2 text-center">{row.partidos_jugados}</td>
              <td className="border p-2 text-center">{row.goles_totales}</td>
              <td className="border p-2 text-center">
                {Number(row.promedio_goles).toFixed(2)}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </main>
  );
}
