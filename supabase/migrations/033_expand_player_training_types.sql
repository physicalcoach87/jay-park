-- Extend the shared player training classification used by GPS and RPE.
-- G = group/individual training, R = rehabilitation training.
ALTER TABLE public.session_records
  DROP CONSTRAINT IF EXISTS session_records_participant_type_check;

ALTER TABLE public.session_records
  ADD CONSTRAINT session_records_participant_type_check
  CHECK (participant_type IS NULL OR participant_type IN ('M', 'S', 'SS', 'X', 'G', 'R'));

COMMENT ON COLUMN public.session_records.participant_type IS
  'Coach/player-selected M/S/SS/X/G/R training classification; NULL falls back to GPS type.';

-- Older databases may already have a restrictive GPS type check under this name.
ALTER TABLE public.gps_records
  DROP CONSTRAINT IF EXISTS gps_records_session_type2_check;

ALTER TABLE public.gps_records
  ADD CONSTRAINT gps_records_session_type2_check
  CHECK (session_type2 IS NULL OR session_type2 IN ('M', 'S', 'SS', 'X', 'G', 'R'));

COMMENT ON COLUMN public.gps_records.session_type2 IS
  'M/S/SS/X/G/R player training classification selected during GPS upload.';
