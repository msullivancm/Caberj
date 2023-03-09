/*/

Autor     : Ronaldo Pena
-----------------------------------------------------------------------------
Data      : 20/09/2007
-----------------------------------------------------------------------------
Descricao : Relatorio de Pagamentos
-----------------------------------------------------------------------------
Partida   : Menu de Usuario

/*/

#Define CRLF Chr(13)+Chr(10)
#include "rwmake.ch"
#include "TopConn.ch"

**********************
User Function CAB002()
**********************
 
  cPerg := "CAB002"
  aSx1  := {}
  Aadd(aSx1,{"GRUPO","ORDEM","PERGUNT"             ,"VARIAVL","TIPO","TAMANHO","DECIMAL","GSC","VALID","VAR01"   ,"F3" ,"DEF01"    ,"DEF02"    ,"DEF03","DEF04","DEF05"})
  Aadd(aSx1,{cPerg  ,"01"   ,"Data de Baixa De...?","mv_ch1" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par01","   ",""         ,""         ,""     ,""     ,""     })
  Aadd(aSx1,{cPerg  ,"02"   ,"Data de Baixa Ate..?","mv_ch2" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par02","   ",""         ,""         ,""     ,""     ,""     })
  Aadd(aSx1,{cPerg  ,"03"   ,"Ano Competencia....?","mv_ch3" ,"C"   ,04       ,0        ,"G"  ,""     ,"mv_par03","   ",""         ,""         ,""     ,""     ,""     })
  Aadd(aSx1,{cPerg  ,"04"   ,"Mes Competencia....?","mv_ch4" ,"C"   ,02       ,0        ,"G"  ,""     ,"mv_par04","   ",""         ,""         ,""     ,""     ,""     })
  Aadd(aSx1,{cPerg  ,"05"   ,"Tipo de Relatorio..?","mv_ch5" ,"N"   ,01       ,0        ,"C"  ,""     ,"mv_par05","   ","Analitico","Sintetico",""     ,""     ,""     })
  Aadd(aSx1,{cPerg  ,"06"   ,"Tipo de Impressao..?","mv_ch6" ,"N"   ,01       ,0        ,"C"  ,""     ,"mv_par06","   ","Normal"   ,"Grafica"  ,""     ,""     ,""     })

  fCriaSX1(cPerg,aSX1)

  Private cDesc1    := ""
  Private cDesc2    := ""
  Private cDesc3    := ""
  Private cString   := "SE2"
  Private aLinha    := {}
  Private aReturn   := {"Zebrado",1,"Financeiro",1,2,1,"",1}
  Private cabec1    := "Tipo Principal                                    Vl.Titulo       Vl.Pagto           IRRF            ISS           INSS           PIS            CSLL          COFINS        Tarifa"
  Private cabec2    := ""
  Private nLastKey  := 0
  Private cTitulo   := "Relacao de Pagamentos"
  Private wnrel     := cPerg
  Private tamanho   := "G"
  Private cNomeprog := cPerg+".PRG"
  Private aOrdem    := {}
  Private cbtxt     := Space(10)
  Private cbcont    := 0
  Private nLin      := 0
  Private m_pag     := 1
  Private lDic      := .F.
  Private lComp     := .F.
  Private lFiltro   := .F.
  Private cTitRel1  := "Relacao de Pagamentos"
  Private cTitRel2  := "Mes/Ano Competencia: "
  Private aBox      := {}
 
  Pergunte(cPerg,.F.)          
  wnrel:=SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,,lFiltro)
  If nLastKey == 27
     Return
  Endif

  SetDefault(aReturn,cString)
  If nLastKey == 27
     Return
  Endif
 
  lAnalitico := mv_par05 == 1
  lImpNormal := mv_par06 == 1
  lContinua  := .T.  
  cTitulo    += " - Mes/Ano Competencia: "+mv_par03+"/"+mv_par04
  
  Processa({|| fProcessa()},"Selecionando Titulos...")
 
  If !lImpNormal
     oFntCur08n:= TFont():New( "Courier New" ,,08,,.F.,,,,,.F. )
     oFntCur08b:= TFont():New( "Courier New" ,,08,,.T.,,,,,.F. )
     oFntCur09b:= TFont():New( "Courier New" ,,09,,.T.,,,,,.F. )
     oFntCur10b:= TFont():New( "Courier New" ,,10,,.T.,,,,,.F. )
     oFntCur11b:= TFont():New( "Courier New" ,,11,,.T.,,,,,.F. )
     oFntCur13b:= TFont():New( "Courier New" ,,13,,.T.,,,,,.F. )
  
     oPrn:=TMSPrinter():New("CABERJ")
     oPrn:SetLandScape()
     oPrn:SetPage(9)
     oPrn:SetSize(210,297)
  Endif

  RptStatus({|| fImprime()},"Aguarde a Impressao...")
     
  If aReturn[5] == 1 .And. lContinua
     If lImpNormal
        Set Printer To
        DbCommitAll()
        Ourspool(wnrel) 
     Else
        oPrn:Preview()
     Endif      
  Endif
  Ms_Flush()
  
Return

***************************
Static Function fProcessa()
***************************

  cQry := " SELECT SE2.E2_BAIXA QRY_BAIXA   ,"
  If lAnalitico
     cQry += CRLF + " SE2.E2_PREFIXO  QRY_PREFIXO ,"
     cQry += CRLF + " SE2.E2_NUM      QRY_NUM     ,"
     cQry += CRLF + " SE2.E2_PARCELA  QRY_PARCELA ,"
     cQry += CRLF + " SE2.E2_TIPO     QRY_TIPO    ,"
     cQry += CRLF + " SE2.E2_NOMFOR   QRY_NOMFOR  ,"
  Else      
     cQry += CRLF + " BAU.BAU_GRPPAG  QRY_GRPCOD  ,"
     cQry += CRLF + " B16.B16_DESCRI  QRY_GRPDESC ,"
  Endif
  
  cQry += CRLF + "  Sum(SE2.E2_VALOR)   QRY_VALOR  ,"
  cQry += CRLF + "  Sum(SE2.E2_VALLIQ)  QRY_VALLIQ ,"
  cQry += CRLF + "  Sum(SE2.E2_IRRF)    QRY_IRRF   ,"
  cQry += CRLF + "  Sum(SE2.E2_ISS)     QRY_ISS    ,"
  cQry += CRLF + "  Sum(SE2.E2_INSS)    QRY_INSS   ,"
  cQry += CRLF + "  Sum(SE2.E2_PIS)     QRY_PIS    ,"
  cQry += CRLF + "  Sum(SE2.E2_COFINS)  QRY_COFINS ,"
  cQry += CRLF + "  Sum(SE2.E2_CSLL)    QRY_CSLL   ,"
  cQry += CRLF + "  Sum(SE2.E2_DECRESC) QRY_DECRESC  " 
  cQry += CRLF + " FROM " + RetSqlName("SE2")+" SE2 "
  cQry += CRLF + "      INNER JOIN "+RetSqlName("BAU") +" BAU ON BAU_CODIGO = SE2.E2_CODRDA"
  cQry += CRLF + "      INNER JOIN "+RetSqlName("B16") +" B16 ON B16_CODIGO = BAU.BAU_GRPPAG"
  cQry += CRLF + " WHERE SE2.E2_FILIAL   = '"+xFilial("SE2") +"'"
  cQry += CRLF + "   AND BAU.BAU_FILIAL  = '"+xFilial("BAU") +"'"
  cQry += CRLF + "   AND B16.B16_FILIAL  = '"+xFilial("BAU") +"'"
  cQry += CRLF + "   AND SE2.D_E_L_E_T_ <> '*' "
  cQry += CRLF + "   AND BAU.D_E_L_E_T_ <> '*' "
  cQry += CRLF + "   AND B16.D_E_L_E_T_ <> '*' "
  cQry += CRLF + "   And SE2.E2_BAIXA   >= '"+Dtos(mv_par01)+"'"
  cQry += CRLF + "   And SE2.E2_BAIXA   <= '"+Dtos(mv_par02)+"'"
  cQry += CRLF + "   And E2_ANOBASE      = '"+mv_par03+"'"
  cQry += CRLF + "   And E2_MESBASE      = '"+mv_par04+"'"
  If lAnalitico
     cQry += CRLF + " GROUP BY SE2.E2_BAIXA,SE2.E2_PREFIXO,SE2.E2_NUM,SE2.E2_PARCELA,SE2.E2_TIPO,SE2.E2_NOMFOR" 
     cQry += CRLF + " ORDER BY SE2.E2_BAIXA,SE2.E2_PREFIXO,SE2.E2_NUM,SE2.E2_PARCELA,SE2.E2_TIPO,SE2.E2_NOMFOR" 
  Else                                                                    
     cQry += CRLF + " GROUP BY SE2.E2_BAIXA,BAU.BAU_GRPPAG,B16.B16_DESCRI"
     cQry += CRLF + " ORDER BY SE2.E2_BAIXA,BAU.BAU_GRPPAG"
  Endif
   
  //MemoWrite("D:\Clientes\Caberj\CAB002.TXT",cQry)
  If TcSqlExec(cQry) < 0
     MsgInfo("Erro na seleção de Registros !!!")
     lContinua := .F.
     Return
  Endif   
  
  If Select("QRY") > 0 ; QRY->(DbCloseArea()) ; Endif
  DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), 'QRY', .F., .T.)

Return

**************************
Static Function fImprime()
**************************
   
Local B := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
   
  If !lContinua ; Return ; Endif
     
  nRegs:= Contar("QRY","!Eof()")
  SetRegua(nRegs)

  If lImpNormal
     nLin := Cabec(cTitulo,cabec1,cabec2,cNomeprog,tamanho,18)    
  Else 
     fImpCabGraf()
  Endif   

  QRY->(DbGoTop())
  While QRY->(!Eof())

        cData   := QRY->QRY_BAIXA
        aTotDia := {0,0,0,0,0,0,0,0,0}
        
        While QRY->(!Eof()) .And. QRY->QRY_BAIXA == cData

              IncRegua()
              
              nValBruto := QRY->(QRY_VALOR + QRY_IRRF + QRY_ISS + QRY_INSS + QRY_PIS + QRY_CSLL + QRY_COFINS)

              If lAnalitico
                 cDesc := QRY->QRY_PREFIXO+ " " +QRY->QRY_NUM+ " " +QRY->QRY_PARCELA+ " " +QRY->QRY_TIPO+ " " +QRY->QRY_NOMFOR
              Else   
                 cDesc := QRY->QRY_GRPCOD +" - " +QRY->QRY_GRPDESC
              Endif  
                             
              If lImpNormal 
               
                 If nLin >= 56
                    nLin := Cabec(cTitulo,cabec1,cabec2,cNomeprog,tamanho,18)
                 Endif
              
                 @ nLin, 001 PSay Left(cDesc,35)
                 @ nLin, 047 PSay Transf(nValBruto        , "@E 9,999,999.99")
                 @ nLin, 062 PSay Transf(QRY->QRY_VALLIQ  , "@E 9,999,999.99")
                 @ nLin, 077 PSay Transf(QRY->QRY_IRRF    , "@E 9,999,999.99")
                 @ nLin, 092 PSay Transf(QRY->QRY_ISS     , "@E 9,999,999.99")
                 @ nLin, 107 PSay Transf(QRY->QRY_INSS    , "@E 9,999,999.99")
                 @ nLin, 122 PSay Transf(QRY->QRY_PIS     , "@E 9,999,999.99")
                 @ nLin, 137 PSay Transf(QRY->QRY_CSLL    , "@E 9,999,999.99")
                 @ nLin, 152 PSay Transf(QRY->QRY_COFINS  , "@E 9,999,999.99")
                 @ nLin, 167 PSay Transf(QRY->QRY_DECRESC , "@E 9,999,999.99")
                 nLin += 1                                             
              
              Else                                                                                                        
                            
                 If nLin > 2300
                    oPrn:EndPage()
                    fImpCabGraf()
                 Endif

                 For B:=1 To Len(aBox)-1
                    oPrn:Box(nLin,aBox[B],nLin+50,aBox[B+1])
                 Next                         
                 oPrn:Say(nLin+20,(aBox[01]+10) , Left(cDesc,35)                              , oFntCur08n,,,,0)                                  
                 oPrn:Say(nLin+20,(aBox[03]-10) , Transf(nValBruto        , "@E 9,999,999.99") , oFntCur08n,,,,1)                                                              
                 oPrn:Say(nLin+20,(aBox[04]-10) , Transf(QRY->QRY_VALLIQ  , "@E 9,999,999.99") , oFntCur08n,,,,1)
                 oPrn:Say(nLin+20,(aBox[05]-10) , Transf(QRY->QRY_IRRF    , "@E 9,999,999.99") , oFntCur08n,,,,1)
                 oPrn:Say(nLin+20,(aBox[06]-10) , Transf(QRY->QRY_ISS     , "@E 9,999,999.99") , oFntCur08n,,,,1)
                 oPrn:Say(nLin+20,(aBox[07]-10) , Transf(QRY->QRY_INSS    , "@E 9,999,999.99") , oFntCur08n,,,,1)
                 oPrn:Say(nLin+20,(aBox[08]-10) , Transf(QRY->QRY_PIS     , "@E 9,999,999.99") , oFntCur08n,,,,1)
                 oPrn:Say(nLin+20,(aBox[09]-10) , Transf(QRY->QRY_CSLL    , "@E 9,999,999.99") , oFntCur08n,,,,1)
                 oPrn:Say(nLin+20,(aBox[10]-10) , Transf(QRY->QRY_COFINS  , "@E 9,999,999.99") , oFntCur08n,,,,1)
                 oPrn:Say(nLin+20,(aBox[11]-10) , Transf(QRY->QRY_DECRESC , "@E 9,999,999.99") , oFntCur08n,,,,1)
                 nLin += 50                                                         
              
              Endif                
              
              aTotDia[01] += nValBruto 
              aTotDia[02] += QRY->QRY_VALLIQ 
              aTotDia[03] += QRY->QRY_IRRF   
              aTotDia[04] += QRY->QRY_ISS    
              aTotDia[05] += QRY->QRY_INSS   
              aTotDia[06] += QRY->QRY_PIS    
              aTotDia[07] += QRY->QRY_CSLL   
              aTotDia[08] += QRY->QRY_COFINS 
              aTotDia[09] += QRY->QRY_DECRESC

              QRY->(DbSkip())
        End  
        
        If lImpNormal 
           @ nLin, 001 PSay "Totais do Dia " + Dtoc(Stod(cData))
           @ nLin, 047 PSay Transf(aTotDia[01] , "@E 9,999,999.99")
           @ nLin, 062 PSay Transf(aTotDia[02] , "@E 9,999,999.99")
           @ nLin, 077 PSay Transf(aTotDia[03] , "@E 9,999,999.99")
           @ nLin, 092 PSay Transf(aTotDia[04] , "@E 9,999,999.99")
           @ nLin, 107 PSay Transf(aTotDia[05] , "@E 9,999,999.99")
           @ nLin, 122 PSay Transf(aTotDia[06] , "@E 9,999,999.99")
           @ nLin, 137 PSay Transf(aTotDia[07] , "@E 9,999,999.99")
           @ nLin, 152 PSay Transf(aTotDia[08] , "@E 9,999,999.99")
           @ nLin, 167 PSay Transf(aTotDia[09] , "@E 9,999,999.99")
           nLin += 2  
        Else                            
           For B:=1 To Len(aBox)-1
               oPrn:Box(nLin,aBox[B],nLin+70,aBox[B+1])
           Next                           
           oPrn:Say(nLin+25,(aBox[01]+10) , "Totais do Dia "+ Dtoc(Stod(cData))     , oFntCur09b,,,,0)                                  
           oPrn:Say(nLin+25,(aBox[03]-10) , Transf(aTotDia[01] , "@E 9,999,999.99") , oFntCur09b,,,,1)                                                              
           oPrn:Say(nLin+25,(aBox[04]-10) , Transf(aTotDia[02] , "@E 9,999,999.99") , oFntCur09b,,,,1)
           oPrn:Say(nLin+25,(aBox[05]-10) , Transf(aTotDia[03] , "@E 9,999,999.99") , oFntCur09b,,,,1)
           oPrn:Say(nLin+25,(aBox[06]-10) , Transf(aTotDia[04] , "@E 9,999,999.99") , oFntCur09b,,,,1)
           oPrn:Say(nLin+25,(aBox[07]-10) , Transf(aTotDia[05] , "@E 9,999,999.99") , oFntCur09b,,,,1)
           oPrn:Say(nLin+25,(aBox[08]-10) , Transf(aTotDia[06] , "@E 9,999,999.99") , oFntCur09b,,,,1)
           oPrn:Say(nLin+25,(aBox[09]-10) , Transf(aTotDia[07] , "@E 9,999,999.99") , oFntCur09b,,,,1)
           oPrn:Say(nLin+25,(aBox[10]-10) , Transf(aTotDia[08] , "@E 9,999,999.99") , oFntCur09b,,,,1)
           oPrn:Say(nLin+25,(aBox[11]-10) , Transf(aTotDia[09] , "@E 9,999,999.99") , oFntCur09b,,,,1)
           nLin += 70                                                                   
           For B:=1 To Len(aBox)-1
               oPrn:Box(nLin,aBox[B],nLin+50,aBox[B+1])
           Next 
           nLin += 50                                                                           
        Endif                                                                                   
  End   
Return

*****************************
Static Function fImpCabGraf()
*****************************

Local B := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

 oPrn:StartPage()

 cFileLogo := "LGRL"+SM0->M0_CODIGO+SM0->M0_CODFIL+".BMP"
 If !File(cFileLogo )
    cFileLogo := "LGRL"+SM0->M0_CODIGO+".BMP"
    If !File(cFileLogo)
       cFileLogo := "LGRL.BMP"
    Endif
 Endi

 oPrn:Box(020,010,0220,0450)
 oPrn:SayBitmap(040,060,cFileLogo,0200,0120)
 oPrn:Say(170,230,Alltrim(cNomeProg+" / "+cVersao),oFntCur09b,,,,2)

 oPrn:Box(020,0450,0220,02900)
 oPrn:Say(070,1675,cTitRel1,oFntCur13b,,,,2)
 oPrn:Say(140,1675,cTitRel2,oFntCur11b,,,,2)

 oPrn:Box(020,2900,0220,3250)
 oPrn:Say(040,2920,"Página : "+Str(oPrn:nPage,8),oFntCur08b,,,,0)
 oPrn:Say(100,2920,"Emissão: "+Dtoc(dDataBase)  ,oFntCur08b,,,,0)
 oPrn:Say(160,2920,"Hora   : "+Time()           ,oFntCur08b,,,,0)
 
 nLin:= 260
 aBox:= {20,1000,1250,1500,1750,2000,2250,2500,2750,3000,3250}
 For B:=1 To Len(aBox)-1
     oPrn:Box(nLin,aBox[B],nLin+70,aBox[B+1])
 Next

 oPrn:Say(nLin+25,(aBox[01]+10) , "Tipo Principal" , oFntCur09b,,,,0)
 oPrn:Say(nLin+25,(aBox[03]-10) , "Vl. Titulo"     , oFntCur09b,,,,1)
 oPrn:Say(nLin+25,(aBox[04]-10) , "Vl. Pagto"      , oFntCur09b,,,,1)
 oPrn:Say(nLin+25,(aBox[05]-10) , "IRRF"           , oFntCur09b,,,,1)
 oPrn:Say(nLin+25,(aBox[06]-10) , "ISS"            , oFntCur09b,,,,1)
 oPrn:Say(nLin+25,(aBox[07]-10) , "INSS"           , oFntCur09b,,,,1)
 oPrn:Say(nLin+25,(aBox[08]-10) , "PIS"            , oFntCur09b,,,,1)
 oPrn:Say(nLin+25,(aBox[09]-10) , "CSLL"           , oFntCur09b,,,,1)
 oPrn:Say(nLin+25,(aBox[10]-10) , "COFINS"         , oFntCur09b,,,,1)
 oPrn:Say(nLin+25,(aBox[11]-10) , "Tarifa"         , oFntCur09b,,,,1)

 nLin +=70
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


