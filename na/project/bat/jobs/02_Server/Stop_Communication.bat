@echo off
net stop SenderReceiver
taskkill /IM communication.exe /F
taskkill /IM communicationApp.exe /F