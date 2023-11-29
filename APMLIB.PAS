{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/CODER/APMLIB-TP)
  @abstract(Target: Turbo Pascal 7)
}

Unit APMLIB;

INTERFACE

Const
 APM_POWER_STANDBY=1;
 APM_POWER_SUSPEND=2;
 APM_POWER_OFF=3;

Function SetAPMMode(Mode:Word):Boolean;

IMPLEMENTATION

Uses DOS;

Function SetAPMMode(Mode:Word):Boolean;
Var
 Regs:Registers;
Begin
 { Connecter l'interface RM }
 Regs.AX:=$5301;
 Regs.BX:=0;
 Intr($15,Regs);
  { Active le pilote APM 1.1 }
 Regs.AX:=$530E;
 Regs.BX:=0;
 Regs.CX:=$0101;
 Intr($15,Regs);
   { Active l'APM }
 Regs.AX:=$5308;
 Regs.BX:=1;
 Regs.CX:=1;
 Intr($15,Regs);
   { Demande la mode sp‚cifier }
 Regs.AX:=$5307;
 Regs.BX:=1;
 Regs.CX:=Mode;
 Intr($15,Regs);
 SetAPMMode:=Regs.Flags and 1=1;
End;

END.