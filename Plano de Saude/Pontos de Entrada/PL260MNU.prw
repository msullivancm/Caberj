#INCLUDE 'PROTHEUS.CH'

User Function PL260MNU
Local aRet := {}
	//P11
	//aadd(aRotina,{ "Bloq.RN 412"	, "u_CABA348()" , 0 , 0, 0   	}) //"Reemissao"				
	//P12
	aAdd(aRet,{'Bloq.RN 412','u_CABA348',0,0})
	
	//Estranhamente o comando acima adiciona 4x a mesma coisa no vetor e �s vezes 2x.
	//Para Corrigir, fa�o a la�o abaixo para deixar apenas 1 dimens�o de 4 posi��es
	For x := 1 to Len(aRet)
		If x > 1
		   aDel(aRet,x)
		   aSize(aRet,x)
		Endif  
	Next x  
	
Return aRet