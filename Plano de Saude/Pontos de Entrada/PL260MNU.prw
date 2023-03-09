#INCLUDE 'PROTHEUS.CH'

User Function PL260MNU
Local aRet := {}
	//P11
	//aadd(aRotina,{ "Bloq.RN 412"	, "u_CABA348()" , 0 , 0, 0   	}) //"Reemissao"				
	//P12
	aAdd(aRet,{'Bloq.RN 412','u_CABA348',0,0})
	
	//Estranhamente o comando acima adiciona 4x a mesma coisa no vetor e às vezes 2x.
	//Para Corrigir, faço a laço abaixo para deixar apenas 1 dimensão de 4 posições
	For x := 1 to Len(aRet)
		If x > 1
		   aDel(aRet,x)
		   aSize(aRet,x)
		Endif  
	Next x  
	
Return aRet