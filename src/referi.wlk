object referiVAR {
	var property modoFuncionamiento = justiciaCiega 
	method terminoEnGol(jugada){
		return jugada.noTieneCircunstanciasEspeciales() ||
		modoFuncionamiento.convalidaElGol(jugada)
	}
} 

object justiciaCiega {
	const circunstancias = ["la pelota no pasó completamente la línea","jugador adelantado","fue con la mano"]

	method convalidaElGol(jugada) {
		return not jugada.tieneAlguna(circunstancias) 
	}
}

object fifa {
	method convalidaElGol(jugada) {
		return jugada.equipo().ganoMundiales() 
	}
}

object masGoles {
	method convalidaElGol(jugada) = true
}

