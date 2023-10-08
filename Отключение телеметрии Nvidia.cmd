schtasks /change /tn NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8} /disable
schtasks /change /tn NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8} /disable
schtasks /change /tn NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8} /disable
net stop NvTelemetryContainer
sc config NvTelemetryContainer start= disabled
sc stop NvTelemetryContainer