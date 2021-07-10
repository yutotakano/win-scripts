@echo off
mshta vbscript:Execute("Set sapi=CreateObject(""SAPI.SpVoice""):Set sapi.Voice = sapi.getVoices.Item(1):sapi.Speak(""%1"")(window.close)")
