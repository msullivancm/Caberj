#INCLUDE "TOTVS.CH"
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE 'TOPCONN.CH'    
#Include "Ap5Mail.Ch"                                                                                                      

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³         ³ Autor ³                       ³ Data ³           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³                  ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Aplicacao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               ³±±
±±³              ³  /  /  ³                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function Caba184()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cDest      := Space(4)
Private cOrigem    := Space(4)
Private lCopia     := .T.
Private lplano     := .F.
Private lRubrica   := .T.
Private lSobres    := .F.
Private cAliastmp1 := GetNextAlias()


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg1","oGrp1","oGrp2","oCBox1","oCBox2","oGrp3","oCBox3","oCBox4","oGrp4","oSay1","oSay2","oGet1")
SetPrvt("oGrp5","oBtn1","oBtn2")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlg1      := MSDialog():New( 092,232,279,621,"Copia / Sobescreve - combinação Contabil",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 000,000,084,188,"Copia / Sobrescreve -Combinação Contabil",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oGrp2      := TGroup():New( 012,004,044,084,"plano / Rubrica ",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )

oCBox1     := TCheckBox():New( 020,020,"Plano ",{|u| If(PCount()>0,lplano:=u,lplano)},oGrp2,048,008,,{||fVdMarc(1)},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
//oCBox1:bLostFocus:={||fVdMarc(1)} 
oCBox2     := TCheckBox():New( 032,020,"Rubrica",{|u| If(PCount()>0,lRubrica:=u,lRubrica)},oGrp2,048,008,,{||fVdMarc(2)},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
//oCBox2:bLostFocus:={||fVdMarc(2)} 
oGrp3      := TGroup():New( 012,096,044,176,"Ação ",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oCBox3     := TCheckBox():New( 020,112,"Copiar ",{|u| If(PCount()>0,lCopia:=u,lCopia)},oGrp3,048,008,,{||fVdMarc(3)},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
//oCBox3:bLostFocus:={||fVdMarc(3)} 
oCBox4     := TCheckBox():New( 033,112,"Sobrescrever",{|u| If(PCount()>0,lSobres:=u,lSobres)},oGrp3,048,008,,{||fVdMarc(4)},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
//oCBox4:bLostFocus:={||fVdMarc(4)} 

oGrp4      := TGroup():New( 048,004,080,084,"Origem / Dest",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 056,012,{||"Origem "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay2      := TSay():New( 068,012,{||"Destino "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oGet1      := TGet():New( 056,036,{|u| If(PCount()>0,cOrigem:=u,cOrigem)},oGrp4,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cOrigem",,)
oGet2      := TGet():New( 068,036,{|u| If(PCount()>0,cDest:=u,cDest)},oGrp4,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cDest",,)
oGrp5      := TGroup():New( 048,096,080,176,"Opções ",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oBtn1      := TButton():New( 060,098,"Faz",oGrp5,{||fAcao()},037,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 060,136,"Sair",oGrp5,{||oDlg1:End()},037,012,,,,.T.,,"",,,,.F. )

oDlg1:Activate(,,,.T.)

Return

Static Function fAcao()

 LOCAL cQuery       := " "  
 Local lFaz         := .T.
 local ret          := ' '
    
    If  (cOrigem == ' ' .or.  cDest == ' ')
       
        ALERT("Origem e/ou Destino , Não Informado  !!!!")
    
        lFaz:= .F.

    EndIf 


    If  lplano     == .T.
    
        If len(TRim(cOrigem)) != 4 .or. len(TRim(cDest)) != 4
           
           lFaz:= .F.

           ALERT("O Plano de origem ou destino deve Ter 4 Digitos , ATENÇÃO  !!!!")    

        EndIf   

    ElseIf lRubrica   == .T. 
        
        If len(TRim(cOrigem)) != 3 .or. len(TRim(cDest)) != 3
           
           lFaz:= .F.
        
           ALERT("O Rubrica  de origem ou destino deve Ter 3 Digitos  , ATENÇÃO  !!!!")    
        
        EndIf
    
    EndIf			

    If lFaz

        cQuery := " select ZUI_FILIAL   FILIAL  , "
        cQuery += CRLF + "ZUI_CODPLA   CODPLA  , "
        cQuery += CRLF + "ZUI_CODTIP   CODTIP  , "
        cQuery += CRLF + "ZUI_CTACLI   CTACLI  , "
        cQuery += CRLF + "ZUI_CTAREC   CTAREC  , "
        cQuery += CRLF + "ZUI_ITRECI   ITRECI  , "
        cQuery += CRLF + "ZUI_CANCLI   CANCLI  , "
        cQuery += CRLF + "ZUI_RECCAN   RECCAN  , "
        cQuery += CRLF + "ZUI_ITCAN    ITCAN   , "
        cQuery += CRLF + "ZUI_MOTBX    MOTBX   , "
        cQuery += CRLF + "ZUI_TPDOC    TPDOC   , "
        cQuery += CRLF + "ZUI_CTADEB   CTADEB  , "
        cQuery += CRLF + "ZUI_CTACRE   CTACRE  , "
        cQuery += CRLF + "ZUI_ITDEB    ITDEB   , "
        cQuery += CRLF + "ZUI_ITCRE    ITCRE   , "
        cQuery += CRLF + "ZUI_PROVRE   PROVRE  , "
        cQuery += CRLF + "ZUI_PREFIX   PREFIX  , "
        cQuery += CRLF + "ZUI_CTBBX    CTBBX   , "
        cQuery += CRLF + "ZUI_TPTIT    TPTIT   , "
        cQuery += CRLF + "ZUI_PREFCP   PREFCP  , "
        cQuery += CRLF + "ZUI_TPDIF    TPDIF   , "
        cQuery += CRLF + "ZUI_TPLANC   TPLANC  , "
        cQuery += CRLF + "R_E_C_N_O_   ZUIREC    "
        cQuery += CRLF + " FROM  " + RetSqlName("ZUI") +" ZUI  "
        cQuery += CRLF + " WHERE  zui_filial = '"+xFilial('ZUI')+ "' and ZUI.d_E_L_E_T_ = ' ' "
        
        If  lplano
            cQuery += CRLF + "   AND ZUI_CODPLA  = '"+cOrigem+"' " 
        ElseIf  lrubrica       
            cQuery += CRLF + "   AND ZUI_CODTIP  = '"+cOrigem+"' "
        EndIf  

        If Select((cAliastmp1)) <> 0 
            (cAliastmp1)->(DbCloseArea())  
        Endif                          

        TCQuery cQuery New Alias (cAliastmp1)   
        
        (cAliastmp1)->( DbGoTop() )  

        DBSELECTAREA("ZUI")   
        ZUI->(dbSetOrder(1))
            
        While (cAliastmp1)->(!Eof())                                    

            iF lCopia
            
                RecLock("ZUI",.T.)     
                
                fMovVarArq()
                
                Msunlock("ZUI")     	       
                    
            Else                 

                DbSelectArea("ZUI")    
		 	
                DbGoto((cAliastmp1)->ZUIREC)
		 	
//                If  ZUI->(dbSeek(xFilial('ZUI')+(cAliastmp1)->CODPLA+(cAliastmp1)->CODTIP )) 

                    ZUI->(Reclock("ZUI",.F.))
                    
                        If lplano     == .T.
              
                           ZUI_CODPLA := TRim(cDest)
              
                        ElseIf lRubrica   == .T.
              
                           ZUI_CODTIP := TRim(cDest)      
              
                        EndIf			

                    Msunlock("ZUI")    

            EndIf 
            
            (cAliastmp1)->(DbSkip())
                                    
        end

        ALERT("Atividade concluída , COPIA / SOBRESCRITA realizado , ATENÇÃO  !!!!")  

        oDlg1:End()

    EndIf

Return(ret)        

static function fMovVarArq()

    ZUI_FILIAL := (cAliastmp1)->FILIAL

    If lplano     == .T.
       ZUI_CODPLA := TRim(cdest)
    Else     
       ZUI_CODPLA := (cAliastmp1)->CODPLA
    EndIf

    If lRubrica   == .T.
       ZUI_CODTIP := TRim(cdest)      
    Else 
       ZUI_CODTIP := (cAliastmp1)->CODTIP  
    EndIf

    ZUI_CTACLI := (cAliastmp1)->CTACLI  
    ZUI_CTAREC := (cAliastmp1)->CTAREC  
    ZUI_ITRECI := (cAliastmp1)->ITRECI  
    ZUI_CANCLI := (cAliastmp1)->CANCLI  
    ZUI_RECCAN := (cAliastmp1)->RECCAN  
    ZUI_ITCAN  := (cAliastmp1)->ITCAN   
    ZUI_MOTBX  := (cAliastmp1)->MOTBX   
    ZUI_TPDOC  := (cAliastmp1)->TPDOC   
    ZUI_CTADEB := (cAliastmp1)->CTADEB  
    ZUI_CTACRE := (cAliastmp1)->CTACRE  
    ZUI_ITDEB  := (cAliastmp1)->ITDEB   
    ZUI_ITCRE  := (cAliastmp1)->ITCRE   
    ZUI_PROVRE := (cAliastmp1)->PROVRE  
    ZUI_PREFIX := (cAliastmp1)->PREFIX  
    ZUI_CTBBX  := (cAliastmp1)->CTBBX   
    ZUI_TPTIT  := (cAliastmp1)->TPTIT   
    ZUI_PREFCP := (cAliastmp1)->PREFCP  
    ZUI_TPDIF  := (cAliastmp1)->TPDIF   
    ZUI_TPLANC := (cAliastmp1)->TPLANC  

Return()

static Function fVdMarc(Ident)

    If Ident == 1
        if lplano
            lRubrica:= .F.
            oCBox1:ctrlrefresh() 
            oCBox2:ctrlrefresh() 
        EndIf 
    ElseIf Ident == 2
        if lRubrica
            lplano := .F.
            oCBox1:ctrlrefresh() 
            oCBox2:ctrlrefresh() 
        EndIf     
    ElseIf Ident == 3
        if lcopia 
            lSobres := .F.
            oCBox3:ctrlrefresh() 
            oCBox4:ctrlrefresh() 
        EndIf     
    ElseIf  Ident == 4
        if  lSobres  
            lcopia := .F.
            oCBox3:ctrlrefresh() 
            oCBox4:ctrlrefresh() 
        EndIf    
    EndIf    

Return()
