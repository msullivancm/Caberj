/*/

Autor     : Leonardo Miranda (Korus Consultoria)
-----------------------------------------------------------------------------
Data      : 23/11/2007
-----------------------------------------------------------------------------
Descricao : Relatorio de Pagamentos Pendentes - DIOPS

/*/
#Define CRLF Chr(13)+Chr(10)
#include "rwmake.ch"
#include "TopConn.ch"               
#Include "Colors.ch"

**********************
User Function CAB005()
**********************

 Private cParam1     := "1;0;1;Relatorio de Pagamentos Pendentes - DIOPS"
 Private cParam2     := ""
 Private cPerg       := "CAB005"
 Private cNomRel     := "DIOPS"
 Private aSx1        := {}
 Private cDataTri    := ""
 Private cDataIni030 := ""
 Private cDataFin030 := ""
 Private cDataIni060 := ""
 Private cDataFin060 := ""
 Private cDataIni090 := ""
 Private cDataFin090 := ""
 Private cDataIni120 := ""
 Private cDataFin120 := ""
 Private cDataIni365 := ""
 Private cDataFin365 := ""
 Private cDataIni366 := ""
 
 Aadd(aSx1,{"GRUPO","ORDEM","PERGUNT"       		,"VARIAVL","TIPO","TAMANHO","DECIMAL","GSC","VALID","VAR01"   ,"F3" ,"DEF01"	,"DEF02" ,"DEF03"	,"DEF04","DEF05"})
 Aadd(aSx1,{cPerg  ,"01"   ,"Período de...?"		,"mv_ch1" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par01","   ",""     	,""      ,""     	,""     ,""     })
 Aadd(aSx1,{cPerg  ,"02"   ,"Período até..?"		,"mv_ch2" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par02","   ",""     	,""      ,""     	,""     ,""     })
 Aadd(aSx1,{cPerg  ,"03"   ,"Ano..........?"		,"mv_ch2" ,"C"   ,04       ,0        ,"G"  ,""     ,"mv_par03","   ",""     	,""      ,""     	,""     ,""     })
 Aadd(aSx1,{cPerg  ,"04"   ,"Trimestre....?"		,"mv_ch3" ,"N"   ,01       ,0        ,"C"  ,""     ,"mv_par04","   ","1°"		,"2°"		,"3°"		,"4°"   ,""     })
 fCriaSX1(cPerg,aSX1)
 
 If !Pergunte(cPerg,.T.)
 	 Return
 Endif

 If mv_par04 == 1
	 cDataTri	:= mv_par03+"0331"
 ElseIf mv_par04 == 2              
	 cDataTri	:= mv_par03+"0631"
 ElseIf mv_par04 == 3              
	 cDataTri	:= mv_par03+"0930"
 ElseIf mv_par04 == 4
	 cDataTri	:= mv_par03+"1231"
 Endif

 cDataIni030 := Dtos(Stod(cDataTri)-1  )
 cDataFin030 := Dtos(Stod(cDataTri)-30 )

 cDataIni060 := Dtos(Stod(cDataTri)-31 )
 cDataFin060 := Dtos(Stod(cDataTri)-60 )
 
 cDataIni090 := Dtos(Stod(cDataTri)-61 )
 cDataFin090 := Dtos(Stod(cDataTri)-90 )
 
 cDataIni120 := Dtos(Stod(cDataTri)-91 )
 cDataFin120 := Dtos(Stod(cDataTri)-120)

 cDataIni365 := Dtos(Stod(cDataTri)-121)
 cDataFin365 := Dtos(Stod(cDataTri)-365)

 cDataIni366 := Dtos(Stod(cDataTri)-366)
 
 cTrimestre  := Alltrim(Str(mv_par04))
 cAno        := mv_par03

 cParam2 := Dtos(mv_par01)+";"+Dtos(mv_par02)+";"+;
            cDataTri      +";"+cDataFin030   +";"+;
            cDataIni030   +";"+cDataFin060   +";"+;
            cDataIni060   +";"+cDataFin090   +";"+;
            cDataIni090   +";"+cDataFin120   +";"+;
            cDataIni120   +";"+cDataFin365   +";"+;
            cDataIni365   +";"+cDataIni366   +";"+;
            cTrimestre    +";"+cAno
 
 CallCrys(cNomRel,cParam2,cParam1) 
 	                 
Return

**************************
Static Function fCriaSx1()
**************************

Local Z 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local X1 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

 SX1->(DbSetOrder(1))
 If !SX1->(DbSeek(cPerg+aSx1[Len(aSx1),2]))
  	 SX1->(DbSeek(cPerg))
	 While SX1->(!Eof()) .And. Alltrim(SX1->X1_GRUPO) == cPerg
          SX1->(Reclock("SX1",.F.,.F.))
          SX1->(DbDelete())
          SX1->(MsunLock())
          SX1->(DbSkip())
    End
	 For X1:=2 To Len(aSX1)
        SX1->(RecLock("SX1",.T.))
        For Z:=1 To Len(aSX1[1])
            cCampo := "X1_"+aSX1[1,Z]
            SX1->(FieldPut(FieldPos(cCampo),aSx1[X1,Z] ))
        Next
        SX1->(MsunLock())
    Next
  Endif
	
Return