-- RPE-only sessions need the same M/S grouping used by GPS uploads.
-- NULL means "no coach override": reports should fall back to gps_records.session_type2,
-- then to M when neither source has a value.
ALTER TABLE session_records
  ADD COLUMN IF NOT EXISTS participant_type text;

ALTER TABLE session_records
  DROP CONSTRAINT IF EXISTS session_records_participant_type_check;

ALTER TABLE session_records
  ADD CONSTRAINT session_records_participant_type_check
  CHECK (participant_type IS NULL OR participant_type IN ('M', 'S', 'SS', 'X'));

COMMENT ON COLUMN session_records.participant_type IS
  'Coach-selected final M/S/SS/X grouping for this RPE session; NULL falls back to GPS type and remains unassigned when GPS is absent.';
