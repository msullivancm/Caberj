/*/

Autor	  : Edilson Leal (Korus Consultoria)
-----------------------------------------------------------------------------
Data	  : 25/01/2008
-----------------------------------------------------------------------------
Descricao : Relatorio de Log de Impressão de Boletos
-----------------------------------------------------------------------------
Partida   : Menu de Usuario

/*/
 #Include "colors.ch"
 #Include "rwmake.ch"
 #Include "Topconn.ch"   
 #Define _LF Chr(13)+Chr(10)
 
*************************
User Function CABAR002()          
*************************            

  aSx1  := {}
  cPerg := "BAR002    "
  cTab  := "LOG_IMP_BOLETO"
  cTrb  := GetNextAlias()
     
  Aadd(aSx1,{"GRUPO","ORDEM","PERGUNT"               ,"VARIAVL" , "TIPO","TAMANHO","DECIMAL","GSC","VALID"     ,"VAR01"    ,"F3"  ,"GRPSXG","DEF01","DEF02","DEF03","DEF04","DEF05"})
  Aadd(aSx1,{cPerg  ,"01"   ,"Filial de.....:"       ,"mv_ch1"  , "C"   ,2        ,0        ,"G"  ,""          ,"mv_par01" ,""    ,""      ,""        ,""         ,""       ,""     ,""    })
  Aadd(aSx1,{cPerg  ,"02"   ,"Filial Ate....:"       ,"mv_ch2"  , "C"   ,2        ,0        ,"G"  ,""          ,"mv_par02" ,""    ,""      ,""        ,""         ,""       ,""     ,""    })
  Aadd(aSx1,{cPerg  ,"03"   ,"Data de.......:"       ,"mv_ch3"  , "D"   ,8        ,0        ,"G"  ,""          ,"mv_par03" ,""    ,""      ,""        ,""         ,""       ,""     ,""    })
  Aadd(aSx1,{cPerg  ,"04"   ,"Data Ate......:"       ,"mv_ch4"  , "D"   ,8        ,0        ,"G"  ,""          ,"mv_par04" ,""    ,""      ,""        ,""         ,""       ,""     ,""    })
  Aadd(aSx1,{cPerg  ,"05"   ,"Prefixo de....:"       ,"mv_ch5"  , "C"   ,3        ,0        ,"G"  ,""          ,"mv_par05" ,""    ,""      ,""        ,""         ,""       ,""     ,""    })
  Aadd(aSx1,{cPerg  ,"06"   ,"Prefixo Ate...:"       ,"mv_ch6"  , "C"   ,3        ,0        ,"G"  ,""          ,"mv_par06" ,""    ,""      ,""        ,""         ,""       ,""     ,""    })
  Aadd(aSx1,{cPerg  ,"07"   ,"Titulo de.....:"       ,"mv_ch7"  , "C"   ,9        ,0        ,"G"  ,""          ,"mv_par07" ,""    ,""      ,""        ,""         ,""       ,""     ,""    })
  Aadd(aSx1,{cPerg  ,"08"   ,"Titulo Ate....:"       ,"mv_ch8"  , "C"   ,9        ,0        ,"G"  ,""          ,"mv_par08" ,""    ,""      ,""        ,""         ,""       ,""     ,""    })  		    
  Aadd(aSx1,{cPerg  ,"09"   ,"Cliente de....:"       ,"mv_ch9"  , "C"   ,6        ,0        ,"G"  ,""          ,"mv_par09" ,"SA1" ,""      ,""        ,""         ,""       ,""     ,""    })
  Aadd(aSx1,{cPerg  ,"11"   ,"Cliente Ate...:"       ,"mv_ch10" , "C"   ,6        ,0        ,"G"  ,""          ,"mv_par10" ,"SA1" ,""      ,""        ,""         ,""       ,""     ,""    })  
   
  ZCriaSx1(cPerg,aSx1)

  If !Pergunte(cPerg,.T.)
	 Return
  Endif 
  
  cQry :=    "SELECT * FROM "+cTab
  cQry +=_LF+" WHERE D_E_L_E_T_ <> '*'"
  cQry +=_LF+" AND FILIAL  BETWEEN '"+mv_par01+"' AND '"+mv_par02+"'"
  cQry +=_LF+" AND HDATA   BETWEEN '"+DtoS(mv_par03)+"' AND '"+DtoS(mv_par04)+"'"
  cQry +=_LF+" AND PREFIXO BETWEEN '"+mv_par05+"' AND '"+mv_par06+"'"
  cQry +=_LF+" AND NUM     BETWEEN '"+mv_par07+"' AND '"+mv_par08+"'"
  cQry +=_LF+" AND CLIENTE BETWEEN '"+mv_par09+"' AND '"+mv_par10+"'"
  cQry +=_LF+" ORDER BY HDATA, HORA, PREFIXO, NUM, TIPO, CLIENTE, LOJA"
        
  If Select(cTrb) > 0  ;  (cTrb)->(DbCloseArea()) ; Endif  
    
  DbUseArea(.T., 'TOPCONN', TCGenQry(,,cQry), cTrb, .F., .T.)		      
  
  (cTrb)->(DbGotop())
  
  If !(cTrb)->(Eof())  
     RptStatus({|| fImprime()},"Aguarde a impressão...")
  Else
     Msgbox("Não existem registros para estes parâmetros!!!")  
  EndIf
  
Return         
                       
 ****************************
 Static Function fImprime()
 ****************************

Local nC := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
   
  Private nLin      := 0 	 	 
  Private nContaReg := 0
  Private oBrush    := TBrush():New( ,CLR_BLACK )
  Private oFnt05    := TFont():New( "Courier New",,05,,.F.,,,,.F.,.F.)
  Private oFnt08    := TFont():New( "Courier New",,08,,.F.,,,,.F.,.F.)
  Private oFnt10    := TFont():New( "Courier New",,10,,.F.,,,,.F.,.F.)
  Private oFnt08N   := TFont():New( "Courier New",,08,,.T.,,,,.F.,.F.)
  Private oFnt10N   := TFont():New( "Courier New",,10,,.T.,,,,.F.,.F.)
  Private oFnt12N   := TFont():New( "Courier New",,12,,.T.,,,,.F.,.F.)
  Private oFnt14N   := TFont():New( "Courier New",,14,,.T.,,,,.F.,.F.)
  Private aBox
  Private aNewBox
  Private aCabNew
  Private aTotReg 
   
  oPrn:=TMSPrinter():New("Log de Impressao de Boletos")  
  oPrn:SetPortrait()
  oPrn:SetPage(9)
  oPrn:SetSize(210,297)                                                                     	 

  SetRegua((cTrb)->(RecCount()))
  
  aBox    := {055     , 170      , 420   , 580   , 780   , 960     , 1200   , 1300     , 1370    , 1600 , 1700     , 1900   ,2100     , 2250, 2400}  
  aCabNew := {"Filial", "Usuario", "Data", "Hora", "Prfx", "Numero", "Parc.", "Tipo"  , "Cliente", "Lj" , "Vencto ", "Valor", "Status", "Documento" } 
  
  fImpCabec()  
  aNewBox := {100,250,500,650,800,1900, 2250, 2400}   
  
  While (cTrb)->(!Eof())       
        	     	    
    	 IncRegua()
       If nLin >= 3150
      	 oPrn:EndPage()     
     		 fImpCabec()          
       EndIf
       
       nContaReg += 1
   	 
   	 aDadNew := {}   	         
   	 Aadd(aDadNew, (cTrb)->FILIAL )
   	 Aadd(aDadNew, (cTrb)->USUARIO)
   	 Aadd(aDadNew,Transform(StoD((cTrb)->HDATA),"@E"))   	  
   	 Aadd(aDadNew, (cTrb)->HORA   )
  	    Aadd(aDadNew, (cTrb)->PREFIXO)
   	 Aadd(aDadNew, (cTrb)->NUM    )
   	 Aadd(aDadNew, (cTrb)->PARCELA)
   	 Aadd(aDadNew, (cTrb)->TIPO   )
   	 Aadd(aDadNew, (cTrb)->CLIENTE)
   	 Aadd(aDadNew, (cTrb)->LOJA   )   	    	 
   	 Aadd(aDadNew, Transform(StoD((cTrb)->VENCREA),"@E"))   	  
   	 Aadd(aDadNew, Transform((cTrb)->VALOR,"@E 999,999.99") )   	    	  		    	  		           
   	 Aadd(aDadNew, (cTrb)->YTPEXP )  	 
   	 Aadd(aDadNew, (cTrb)->NUMBCO )  	 
   	 
       For nC := 1 to Len(aBox)-1
           oPrn:Box(nLin,aBox[nC], nLin+45,aBox[nC+1])    
       Next
         	    	  		 
       For nC  := 1 to Len(aBox)-1                                                                            
           oPrn:Say(nLin+10,(aBox[nC]+aBox[nC+1])/2,aDadNew[nC],oFnt08,,,,2)  
       Next     
   	 nLin += 40
   	 
       (cTrb)->(DbSkip())
  End       
  
  nLin += 20  
  oPrn:Say(nLin+10,(55+170)/2,"    Total de Registros Processados ..:  " + strzero(nContaReg,6),oFnt10n,,,,2)  
   	  
  oPrn:EndPage()
  oPrn:Preview()

  If Select(cTrb) > 0  ;  (cTrb)->(DbCloseArea()) ; Endif  

Return 

***************************
Static Function fImpCabec()
***************************

Local C := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
 
 cLogo := "LGRL"+SM0->M0_CODIGO+SM0->M0_CODFIL+".BMP"
 If !File(cLogo)
    cLogo := "LGRL"+SM0->M0_CODIGO+".BMP"
    If !File(cLogo)  
       cLogo := "LGRL.BMP"
    Endif
 Endif
    
 oPrn:StartPage()
 
 aBoxCab := {055,450,1900,2250}
 For C:=1 To Len(aBoxCab) -1 				  
     oPrn:Box(50,aBoxCab[C],200,aBoxCab[C+1])
 Next  
 
 oPrn:SayBitmap(100, aBoxCab[1]+20, cLogo, 320, 90) 
 oPrn:Say(160,(aBoxCab[1]+aBoxCab[2])/2    ,"CABAR002.Prw"                                      ,oFnt05 ,,,,2)
 oPrn:Say(085,(aBoxCab[2]+aBoxCab[3])/2    ,"Log de Impressão de Boletos"                       ,oFnt14n,,,,2)
 oPrn:Say(150,(aBoxCab[2]+aBoxCab[3])/2    ,"Data de "+Transform(mv_par03,"@E")+" Até "+Transform(mv_par04,"@E"),oFnt10n,,,,2)  	  
 oPrn:Say(055,(aBoxCab[3]+aBoxCab[4])/2    ,"Emissão: "+Dtoc(Date())                           ,oFnt08,,,,2) 
 oPrn:Say(085,(aBoxCab[3]+aBoxCab[4])/2    ,"Hora   : "+Time()                                 ,oFnt08,,,,2) 
 oPrn:Say(115,(aBoxCab[3]+aBoxCab[4])/2    ,"Página : "+AllTrim(Str(oPrn:nPage,8))             ,oFnt08,,,,2) 
 nLin := 210
 
 For C:=1 To Len(aBox) -1
     oPrn:Box(nLin,aBox[C],nLin+60,aBox[C+1])
     oPrn:Say(nLin+15,(aBox[C]+aBox[C+1])/2  , aCabNew[C],oFnt08n,,,,2)
 Next
  
 nLin+=60
            
 
Return    

*--------------------------------*
Static Function ZCriaSx1(cPerg,aSx1)
*--------------------------------*

Local Z 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local X1 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

 DbSelectArea("SX1")
 DbGoTop()
 DbSetOrder(1)                                   
 padr(cPerg,10)

 If !DbSeek(cPerg+aSx1[Len(aSx1),2])
	DbSeek(cPerg)
	While !Eof() .And. Alltrim(SX1->X1_GRUPO) == cPerg
		  Reclock("SX1",.F.,.F.)
          DbDelete()
		  MsunLock()
		  DbSkip()
	End
    For X1:=2 To Len(aSX1)
		RecLock("SX1",.T.)
           For Z:=1 To Len(aSX1[1])
               cCampo := "X1_"+aSX1[1,Z]
               FieldPut(FieldPos(cCampo),aSx1[X1,Z] )
           Next
		MsunLock()
	Next
 Endif
Return

