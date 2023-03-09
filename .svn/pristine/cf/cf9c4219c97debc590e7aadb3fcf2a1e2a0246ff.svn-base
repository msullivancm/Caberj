/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CABA212³ Autor ³ Luiz Otavio Campos     ³ Data ³ 05.03.21  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ funções para a geração do CNAB de cobrança BRADESCO        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Advanced Protheus                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
*/

/************************************************************************/
/* Retorna o numero sequencial do CNAB
/************************************************************************/

User FunctIon CABA212A
Local _nSeqCnab := SuperGetMV("MV_YSEQCNA",.f.,1) 
        
        putMV("MV_YSEQCNA",_nSeqCnab+1) 

return STRZERO(_nSeqCnab,7)


/************************************************************************/
/* Retorna o CODIGO  da empresa
/************************************************************************/
User FunctIon CABA212B
Local cCodEmp := STRZERO(VAL(SEE->EE_CODCART),4)+STRZERO(VAL(SEE->EE_AGENCIA),5)+STRZERO(VAL(SEE->EE_CONTA),7)+ALLTRIM(SEE->EE_DVCTA)

return cCodEmp


/************************************************************************/
/* Grava o Codigo do Nosso numero  no titutlo
/************************************************************************/
User Function CABA212C()  

	Local aAreaSEE := GetArea("SEE") // Marcela Coimbra
	Local aAreaSEE := GetArea("SE1") // Marcela Coimbra
    
    If Empty(SE1->E1_NUMBCO)
        //
        DbSelectArea("SEE")
        //		
        _cNUMBCO 	:= SEE->EE_FAXATU 
        //INCREMENTA O NOSSO NUMERO
        cNumAtu := soma1(Substr(SEE->EE_FAXATU,1,Len(Alltrim(SEE->EE_FAXATU))))
        SEE->(RecLock("SEE",.F.))
        SEE->EE_FAXATU := cNumAtu
        SEE->(MsUnlock())
        //
        DbSelectArea("SE1")
        Reclock("SE1",.F.)
        SE1->E1_NUMBCO	:=	_cNUMBCO	
        MsUnlock()
    Else    
        _cNUMBCO := SE1->E1_NUMBCO	
    EndIf                

	RestArea( aAreaSEE ) // Marcela Coimbra
	RestArea( aAreaSEE ) // Marcela Coimbra
	
Return(_cNUMBCO)



/*******************************************************************************************/
/* Calcula o Digito Verificador do Nosso numero
/*******************************************************************************************/

User Function CABA212D(cCartCob,cNosNum)
	
	Local nRes1 	:= 0
	Local nRes2 	:= 0
	Local nRes3 	:= 0
	Local nRes4 	:= 0
	Local nRes5 	:= 0
	Local nRes6 	:= 0
	Local nRes7 	:= 0
	Local nRes8 	:= 0
	Local nRes9 	:= 0
	Local nRes10 	:= 0
	Local nRes11 	:= 0
	Local nRes12 	:= 0
	Local nRes13 	:= 0
	Local nTotDG	:= 0
	Local nResDG	:= 0
	Local nRstDG	:= 0
	
	//
	If empty(cCartCob)
		cCartCob	:= "09"
	Endif
	nRes1	:=	val(substr(cCartCob,1,1)) * 2
	nRes2	:=	val(substr(cCartCob,2,1)) * 7
	nRes3	:=	val(substr(cNosNum,1,1))  * 6
	nRes4	:=	val(substr(cNosNum,2,1))  * 5
	nRes5	:=	val(substr(cNosNum,3,1))  * 4
	nRes6	:=	val(substr(cNosNum,4,1))  * 3
	nRes7	:=	val(substr(cNosNum,5,1))  * 2
	nRes8	:=	val(substr(cNosNum,6,1))  * 7
	nRes9	:=	val(substr(cNosNum,7,1))  * 6
	nRes10	:=	val(substr(cNosNum,8,1))  * 5
	nRes11	:=	val(substr(cNosNum,9,1))  * 4
	nRes12	:=	val(substr(cNosNum,10,1)) * 3
	nRes13	:=	val(substr(cNosNum,11,1)) * 2
	//
	nTotDG	:=	nRes1 + nRes2 + nRes3 + nRes4 + nRes5 + nRes6 + nRes7 + nRes8 + nRes9 + nRes10 + nRes11 + nRes12 + nRes13
	//
	nResDG	:=	int(nTotDg / 11)
	nRstDG	:=	nTotDG -  (nResDG * 11)
	//
	nDig	:=	11 - nRstDG
	//
	Do Case
	Case nRstDG =  1
		cDig	:= "P"
	Case nRstDG =  0
		cDig	:= "0"
	Otherwise
		cDig	:= alltrim(str(nDig))
	Endcase
	//
Return cDig
