#Include 'Protheus.ch'

//******************************************************
// Autor: Mateus Medeiros 
// Valida��o: Valida E-mail - A pedido do �lina  
// Data: 10/11/2017
//******************************************************
User function CABV037( cEmail )
	
	local nCont := 1

	local lRet   := .T.

	local nResto := 0

	Local cMens := ""      
	

	IF !Empty(cEmail) // somente far� a valida��o se o e-mail for informado

		cMens := "Todo E-mail tem que ter (@) e terminar com (.com) ou (.com.br)."

		cMens += +Chr(10)+Chr( 13)+"Exemplo:"+Chr(10)+Chr( 13)+Chr(10)+Chr( 13)

		cMens += +space(02)+"vendas@caberj.com.br"+Chr(10)+Chr( 13)+space( 02)+"fulano@email.com"

		cMens += +Chr(10)+Chr( 13)+" "+Chr(10)+Chr( 13)+"Foi digitado ( "+alltrim(cEmail) +" )"
	
		if (';' $ cEmail)
			aMails := STRTOKARR(alltrim(cEmail),';')
		else
			aMails := {alltrim(cEmail)}
		endif
	
		For nX := 1 to len(aMails)
		
			If !IsEmail(alltrim(aMails[nX]))
		
			//APMSGALERT(cMens,"Aten��o !!! - E-mail inv�lido ...")
				AVISO( "Aten��o !!! - E-mail inv�lido ...",cMens,  {"OK"})
				lRet := .F.

			else

				if ( nResto := at( "@", alltrim(aMails[nX]) )) > 0 .and. at( "@", right( alltrim(aMails[nX]), len( alltrim(aMails[nX]) ) - nResto )) == 0

					if ( nResto := at( ".", right(alltrim(aMails[nX]), len( alltrim(aMails[nX]) ) - nResto ))) > 1 .and. right(alltrim(aMails[nX]),1) <> '.'// N�O PERMITE PONTO AP�S O ARROBA (@)

						lRet := .T.

					else
						AVISO( "Aten��o !!! - E-mail inv�lido ...",cMens,  {"OK"})
					//APMSGALERT(cMens,"Aten��o !!! - E-mail inv�lido ...")

						lRet := .F.

					endif

				else

				//APMSGALERT(cMens,"Aten��o !!! - E-mail inv�lido ...")
					AVISO( "Aten��o !!! - E-mail inv�lido ...",cMens,  {"OK"})
				
					lRet := .F.

				endif

			endif
	
		Next nX

	endif

return lRet