import referi.*
import equipo.*

class Jugada {
	var property minuto = 1
	var property jugador = null
	
	method esSegundoTiempo() = minuto > 45	
	
	method cuantasTarjetasPara(equipo){
		return if (self.sacaTarjeta() && jugador.equipo() == equipo) 1 else 0
	}
	method sacaTarjeta()
	
	method esGolDe(equipo) = false
}

class JugadaDeGol inherits Jugada{

	const circunstanciasEspeciales = []
	
	method esGol() {
		return referiVAR.terminoEnGol(self)  
	}
	override method esGolDe(equipo) {
		return self.esGol() && self.equipo() == equipo 
	}
	
	override method sacaTarjeta() = self.tiene("saco camiseta")
	
	method equipo() = jugador.equipo()
	
	method noTieneCircunstanciasEspeciales() = circunstanciasEspeciales.isEmpty()
	
	method tieneAlguna(circunstancias) = circunstancias.any{cir=>self.tiene(cir)}
	
	method tiene(circunstancia) = circunstanciasEspeciales.contains(circunstancia)
	
}


class Falta  inherits Jugada{
	var intensidadDeLaFalta
	
	override method sacaTarjeta() {
 		return intensidadDeLaFalta > 75
	}
}

class PeleaEnLaCancha inherits Jugada{
	var jugadores = []
	
	override method sacaTarjeta() {
		return 
			jugadores.size() > 5 && 
			self.cantidadEquipos() == 2
	}
	method cantidadEquipos() = jugadores.map{jugador=>jugador.equipo()}.asSet().size() 
	
	override method cuantasTarjetasPara(equipo){
		return if (self.sacaTarjeta()) self.cuantosJugadoresDe(equipo) else 0
	}
	method cuantosJugadoresDe(equipo){
		return jugadores.count{jugador=>jugador.equipo() == equipo}
	}
}

class Insulto inherits Jugada {
	var insultoDicho
	
	override method sacaTarjeta() {
       return insultoDicho == "madre"
	}
}

