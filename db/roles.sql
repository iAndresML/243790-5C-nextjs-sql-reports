-- ============================================
-- ROLES.SQL
-- Usuario de aplicación con permisos mínimos
-- ============================================

CREATE ROLE app_user LOGIN PASSWORD 'app123';

GRANT CONNECT ON DATABASE champions_league TO app_user;

GRANT USAGE ON SCHEMA public TO app_user;

-- Permitir solo SELECT en VIEWS
GRANT SELECT ON
view_team_performance,
view_players_by_position,
view_stadium_usage,
view_team_goal_ranking,
view_high_scoring_matches_by_phase
TO app_user;
