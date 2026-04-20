<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Academia Militar Comando Lince</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&family=Oswald:wght@500;700&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
:root {
	--primary-color: #1a237e;
	--secondary-color: #2e7d32;
	--accent-color: #ffc107;
	--dark-bg: #121212;
}

body {
	font-family: 'Roboto', sans-serif;
	background-color: #f8f9fa;
}

h1, h2, h3, .navbar-brand {
	font-family: 'Oswald', sans-serif;
	text-transform: uppercase;
}

.navbar {
	background-color: var(--primary-color) !important;
	border-bottom: 4px solid var(--accent-color);
}


/*------------------------- Hero ---------------------- */
.hero {
	position: relative;
	height: 80vh;
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
	color: white;
	overflow: hidden;
}


/*------------------------- Imagenes ---------------------- */
.hero-slide {
	position: absolute;
	inset: 0;
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	opacity: 0;
	animation: slider 20s infinite;
}


/*------------------------- las imagenes img ---------------------- */
.slide1 {
	background-image: url("img/militar1.jpg");
	animation-delay: 0s;
}
.slide2 {
	background-image: url("img/militar2.jpg");
	animation-delay: 05s;
}
.slide3 {
	background-image: url("img/militar3.jpg");
	animation-delay: 10s;
}
.slide4 {
	background-image: url("img/militar4.jpg");
	animation-delay: 20s;
}


/*------------------------- oscurecer ---------------------- */
.overlay {
	position: absolute;
	inset: 0;
	background: rgba(0,0,0,0.55);
}


/*------------------------- Contenido ---------------------- */
.hero-content {
	position: relative;
	z-index: 2;
}


/*------------------------- Animacion ---------------------- */
@keyframes slider {
	0% { opacity: 0; }
	5% { opacity: 1; }
	20% { opacity: 1; }
	25% { opacity: 0; }
	100% { opacity: 0; }
}


/*------------------------- Boton ---------------------- */
.btn-militar {
	background-color: var(--secondary-color);
	color: white;
	padding: 14px 35px;
	font-weight: bold;
	border: none;
	border-radius: 8px;
}

.btn-militar:hover {
	background-color: #1b5e20;
	color: var(--accent-color);
}


/*------------------------- tarjetas ---------------------- */
.card-value {
	border: none;
	border-top: 5px solid var(--primary-color);
	transition: transform 0.3s;
}

.card-value:hover {
	transform: translateY(-10px);
	box-shadow: 0 10px 20px rgba(0,0,0,0.1);
}

.icon-box {
	font-size: 3rem;
	color: var(--secondary-color);
	margin-bottom: 15px;
}

/*------------------------- footer ---------------------- */

footer {
	background-color: var(--dark-bg);
	color: white;
	padding: 50px 0;
}
</style>
</head>

<body>


<!-------------------------- navbar  ---------------------->
<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
	<div class="container">
		<a class="navbar-brand" href="#">
			<i class="fas fa-shield-halved me-2"></i> COMANDO LINCE
		</a>

		<div class="ms-auto">
			<a class="btn btn-outline-warning" href="login.jsp">
				<i class="fas fa-lock me-1"></i> Ingresa
			</a>
		</div>
	</div>
</nav>

<!-------------------------- hero  ---------------------->
<header class="hero">

	<div class="hero-slide slide1"></div>
	<div class="hero-slide slide2"></div>
	<div class="hero-slide slide3"></div>
	<div class="hero-slide slide4"></div>

	<div class="overlay"></div>

	<div class="container hero-content">
		<h1>HONOR, DISCIPLINA Y VALOR</h1>
		<p class="lead mb-4">Formando líderes para el futuro</p>

		<a href="#" class="btn btn-militar btn-lg">
			INICIAR PROCESO DE ADMISIÓN
		</a>
	</div>

</header>

<!-------------------------- pilares  ---------------------->
<section class="py-5">
	<div class="container">
		<div class="text-center mb-5">
			<h2 class="fw-bold">Nuestros Pilares Institucionales</h2>
			<div style="width: 80px; height: 4px; background: var(--accent-color); margin:auto;"></div>
		</div>

		<div class="row g-4 text-center">

			<div class="col-md-4">
				<div class="card h-100 p-4 card-value">
					<div class="icon-box">
						<i class="fas fa-gavel"></i>
					</div>
					<h3 class="h4">Disciplina</h3>
					<p class="text-muted">El cumplimiento estricto de las normas.</p>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card h-100 p-4 card-value">
					<div class="icon-box">
						<i class="fas fa-medal"></i>
					</div>
					<h3 class="h4">Honor</h3>
					<p class="text-muted">Integridad en cada acción.</p>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card h-100 p-4 card-value">
					<div class="icon-box">
						<i class="fas fa-users"></i>
					</div>
					<h3 class="h4">Lealtad</h3>
					<p class="text-muted">Compromiso con la patria.</p>
				</div>
			</div>

		</div>
	</div>
</section>

<!---------------------------Footer  ---------------------->
<footer>
	<div class="container text-center">
		<h5>COMANDO SUPERIOR DE EDUCACIÓN MILITAR</h5>
		<p>Dirección Institucional</p>
		<p>&copy; 2024 Academia Militar Comando Lince</p>
	</div>
</footer>

</body>
</html>