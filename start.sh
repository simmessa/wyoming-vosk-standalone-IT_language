flags=()

CORRECT_SENTENCES="${CORRECT_SENTENCES:-0.0}"
PRELOAD_LANGUAGE="${PRELOAD_LANGUAGE:-en}"

if [ "${DEBUG_LOGGING}" == "TRUE" ]; then
    flags+=('--debug')
fi

if [ "${LIMIT_SENTENCES}" == "TRUE" ]; then
    flags+=('--limit-sentences')
fi

if [ "${ALLOW_UNKNOWN}" == "TRUE" ]; then
    flags+=('--allow-unknown')
fi

echo CORRECT_SENTENCES = ${CORRECT_SENTENCES}
echo PRELOAD_LANGUAGE  = ${PRELOAD_LANGUAGE}
echo DEBUG_LOGGING     = ${DEBUG_LOGGING}
echo LIMIT_SENTENCES   = ${LIMIT_SENTENCES}
echo ALLOW_UNKNOWN     = ${ALLOW_UNKNOWN}

if [ -d '/share/vosk/models' ]; then
  # Each directory is a language name with a model inside
  while read -r lang_dir; do
      # Override the model for this language
      lang="$(basename "${lang_dir}")"
      flags+=('--model-for-language' "${lang}" "$(realpath "${lang_dir}")")
  done < <(find '/share/vosk/models' -mindepth 1 -maxdepth 1 -type d)
fi

echo flags = ${flags[@]}
python3 -m wyoming_vosk \
    --uri 'tcp://0.0.0.0:10300' \
    --download-dir /data \
    --data-dir /share/vosk/models \
    --sentences-dir /share/vosk/sentences \
    --correct-sentences $CORRECT_SENTENCES \
    --language $PRELOAD_LANGUAGE \
    --preload-language $PRELOAD_LANGUAGE ${flags[@]}
