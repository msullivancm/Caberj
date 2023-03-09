#Include 'Protheus.ch'

//******************************************************
// Autor: Mateus Medeiros 
// Validação: validação do campo BD6_CODPRO e BD7_CODPRO - A pedido do Felipe e Sergio  
// Data: 10/10/2017
//******************************************************
User Function CaBv036(cCampo)

	Local aArea 	:= getarea()
	Local aAreaBD7  := BD7->(getarea())
	Local cRet      := ""
	Local nInt		:= 0 
	Local nColsBd7	:= 0 
	if cCampo == 1 	
		cRet := IIf(Inclui,"HOSPITAL/LABORATORIOS/CLINICAS",BWT->(Posicione("BWT",1,xFilial("BWT")+BD6->BD6_CODOPE+BD7->BD7_CODTPA,"BWT_DESCRI")))
	elseif cCampo == 3  // BD6_CODPRO
		// Mateus Medeiros - 15/08/2018 - Para corrigir o preenchimento do "H" no campo CODTPA quando as guias forem de internação
		if type("aColsBD7") == "A"
			nColsBd7 := len(aColsBD7)
		endif 
		// validação do campo BD6_CODPRO - Para que seja alimentado o campo bd6_codpro
		// pq o padrão zera a informação do gatilho 	
		// validação padrão do campo
		cRet := PLSMUDCOD("BD6").AND.PLSA720VPR().And.PLSA720GAT().And.PLSGATNIV(M->BD6_CODPAD,M->BD6_CODPRO,"BD6",,,BD6->(Recno()))            	

		if cRet	
			if type("oBrwBD7") == "O"
				// variavel oBrwBD7 - private criada na PLSA720GAT ( função padrão )
				if ascan(oBrwBD7:aHeader,{|x| x[2] == "BD7_CODTPA"}) > 0  // SOMENTE INTERNAÇÃO
					nInt := ascan(oBrwBD7:aCols,{|x| x[ascan(oBrwBD7:aHeader,{|x| x[2] == "BD7_SEQUEN"})] == M->BD6_SEQUEN},1)
					While nInt > 0 
						//if oBrwBD7:ACOLS[nInt][ascan(oBrwBD7:aHeader,{|x| x[2] == "BD7_SEQUEN"})] == M->BD6_SEQUEN
						oBrwBD7:ACOLS[nInt][ascan(oBrwBD7:aHeader,{|x| x[2] == "BD7_CODTPA"})] := 'H'
						nInt+=1
						nInt := ascan(oBrwBD7:aCols,{|x| x[ascan(oBrwBD7:aHeader,{|x| x[2] == "BD7_SEQUEN"})] == M->BD6_SEQUEN},nInt)

						if nInt == 0 
							Exit 
						endif 	
					enddo 
				endif 
			endif
		endif 	 	

	else 
		if Inclui
			cRet := "H"
		endif 
	endif 
	//oBrwBD7:aCols
	RestArea(aAreaBD7)	
	RestArea(aArea)	

Return cRet

