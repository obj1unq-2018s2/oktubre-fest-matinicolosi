class Carpa {
	const property limitePersonas = 0
	var property personas = #{}
	const property jarrasCerveza = #{}
	const property tieneBanda = false
	method cantidadPersonas () {
		return personas.size()
	}
	method puedeEntrar (persona) {
		return self.cantidadPersonas() < limitePersonas and not persona.estaEbria()
	}
	method entra (persona) {
		if (self.puedeEntrar(persona))
		personas.add(persona)
		else self.error("No cumple las condiciones")
	}
	method cantidadEbriosEmpedernidos () {
		return personas.filter{persona => persona.estaEbria() and persona.empedernido()}.size()
	}
}

class Jarra {
	const property marcaCerveza = null
	const property litros = null
	method contenidoAlcohol () {
		return litros * marcaCerveza.graduacion()
	}	
}

class Marca {
	const property lupulo = 0
	const property pais = ""
}

class CervezaRubia inherits Marca {
	const property graduacion = 10
}

class CervezaNegra inherits Marca {
const property graduacionReglamentaria = 12
	method graduacion () {
		return [lupulo * 2, graduacionReglamentaria].min()
	}
}

class CervezaRoja inherits CervezaNegra {
	override method graduacion () {
		return super() * 1.25
	}
}

class Persona {
	const property peso = 0
	const property jarrasCompradas = #{}
	const property leGustaEscucharMusica = true //booleano
	const property nivelAguante = 30
	method cantidadDeAlcohol () {
		return jarrasCompradas.sum{jarra => jarra.contenidoAlcohol ()}
	}
	method estaEbria () {
		return self.cantidadDeAlcohol() * peso > nivelAguante
	}
	method empedernido () {
		jarrasCompradas.all{jarra => jarra.litrosContenido() <= 1}
	}
}

class Belga inherits Persona {
	const nacionalidad = "Belgica" 
	method leGustaLaMarca (marca) {
		return marca.lupulo() > 4
	}
	method quiereEntrar (carpa) {
		return carpa.tieneBanda() == leGustaEscucharMusica and self.leGustaLaMarca(carpa.marca())
	}
	method puedeEntrar (carpa) {
		return self.quiereEntrar(carpa) and carpa.puedeEntrar(self)
	}
	method esPatriota () {
		return jarrasCompradas.all{jarra => jarra.marcaCerveza().pais() == nacionalidad}
	}
}

class Checo inherits Persona {
	const nacionalidad = "Republica Checa" 
	method leGustaLaMarca (marca) {
		return marca.graduacion() > 8
	}
	method quiereEntrar (carpa) {
		return carpa.tieneBanda() == leGustaEscucharMusica and self.leGustaLaMarca(carpa.marca())
	}
	method puedeEntrar (carpa) {
		return self.quiereEntrar(carpa) and carpa.puedeEntrar(self)
	}
	method esPatriota () {
		return jarrasCompradas.all{jarra => jarra.marcaCerveza().pais() == nacionalidad}
	}
}

class Aleman inherits Persona {
	const nacionalidad = "Alemania" 
	method leGustaLaMarca (marca) {
		return true
	}
	method quiereEntrar (carpa) {
		return carpa.tieneBanda() == leGustaEscucharMusica and self.leGustaLaMarca(carpa.marca()) and not carpa.cantidadPersonas().odd()
	}
	method puedeEntrar (carpa) {
		return self.quiereEntrar(carpa) and carpa.puedeEntrar(self)
	}
	method esPatriota () {
		return jarrasCompradas.all{jarra => jarra.marcaCerveza().pais() == nacionalidad}
	}
}