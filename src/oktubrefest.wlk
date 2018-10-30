class Carpa {
	const property limitePersonas = 0
	const property jarrasCerveza = #{}
	const property tieneBanda = false
}

class Jarra {
	const property marcaCerveza = null
	const property litrosJarra = null	
}

class Persona {
	const property peso = 0
	const property jarrasCompradas = #{}
	const property leGustaEscucharMusica = true //booleano
	const property nivelAguante = 30
	const property nacionalidad = null
	method estaEbria () {
		return cantidadDeAlcohol * peso > nivelAguante
	}
}