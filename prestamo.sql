-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-09-2021 a las 22:58:30
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `prestamo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `cliente_id` int(10) NOT NULL,
  `cliente_dni` varchar(30) COLLATE utf8_spanish2_ci NOT NULL,
  `cliente_nombre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `cliente_apellido` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `cliente_telefono` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `cliente_direccion` varchar(200) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`cliente_id`, `cliente_dni`, `cliente_nombre`, `cliente_apellido`, `cliente_telefono`, `cliente_direccion`) VALUES
(1, '72308749', 'Jose Smit', 'Espinoza Miranda', '918235459', 'Huaraz'),
(2, '121212121212', 'Guillermo', 'Buenos Aires', '100200300400', 'Argentina');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle`
--

CREATE TABLE `detalle` (
  `detalle_id` int(100) NOT NULL,
  `detalle_cantidad` int(10) NOT NULL,
  `detalle_formato` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `detalle_tiempo` int(7) NOT NULL,
  `detalle_costo_tiempo` decimal(30,2) NOT NULL,
  `detalle_descripcion` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `prestamo_codigo` varchar(200) COLLATE utf8_spanish2_ci NOT NULL,
  `item_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `detalle`
--

INSERT INTO `detalle` (`detalle_id`, `detalle_cantidad`, `detalle_formato`, `detalle_tiempo`, `detalle_costo_tiempo`, `detalle_descripcion`, `prestamo_codigo`, `item_id`) VALUES
(2, 2, 'Mes', 34, '233.00', '001 Mesa Plástica', 'CP9522663-2', 1),
(4, 12, 'Horas', 12, '12.00', '001 Mesa Plástica', 'CP9546948-2', 1),
(5, 12, 'Horas', 12, '12.00', '001 Mesa Plástica', 'CP2373352-3', 1),
(6, 15, 'Horas', 15, '15.00', '001 Mesa Plástica', 'CP9819350-4', 1),
(7, 12, 'Horas', 6, '3.00', '001 Mesa Plástica', 'CP5013588-5', 1),
(8, 24, 'Horas', 12, '6.00', '002 Silla Plástica', 'CP5013588-5', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `empresa_id` int(2) NOT NULL,
  `empresa_nombre` varchar(90) COLLATE utf8_spanish2_ci NOT NULL,
  `empresa_email` varchar(70) COLLATE utf8_spanish2_ci NOT NULL,
  `empresa_telefono` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `empresa_direccion` varchar(200) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`empresa_id`, `empresa_nombre`, `empresa_email`, `empresa_telefono`, `empresa_direccion`) VALUES
(1, 'Desinglopers SA', 'desinglopers1@gmail.com', '0000000000000', 'Argentina');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `item`
--

CREATE TABLE `item` (
  `item_id` int(10) NOT NULL,
  `item_codigo` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `item_nombre` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `item_stock` int(10) NOT NULL,
  `item_estado` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `item_detalle` varchar(200) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `item`
--

INSERT INTO `item` (`item_id`, `item_codigo`, `item_nombre`, `item_stock`, `item_estado`, `item_detalle`) VALUES
(1, '001', 'Mesa Plástica', 50, 'Habilitado', 'Mesas de Plástico'),
(2, '002', 'Silla Plástica', 80, 'Habilitado', 'Sillas de Plástico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `pago_id` int(20) NOT NULL,
  `pago_total` decimal(30,2) NOT NULL,
  `pago_fecha` date NOT NULL,
  `prestamo_codigo` varchar(200) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `pago`
--

INSERT INTO `pago` (`pago_id`, `pago_total`, `pago_fecha`, `prestamo_codigo`) VALUES
(2, '3432432.00', '2021-07-02', 'CP9522663-2'),
(4, '2.00', '2021-07-01', 'CP9546948-2'),
(5, '1728.00', '2021-07-07', 'CP2373352-3'),
(6, '2.00', '2021-07-01', 'CP9546948-2'),
(7, '2.00', '2021-07-01', 'CP9546948-2'),
(8, '5.00', '2021-07-12', 'CP9546948-2'),
(9, '3375.00', '2021-07-14', 'CP9819350-4'),
(10, '1000.00', '2021-07-16', 'CP5013588-5');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo`
--

CREATE TABLE `prestamo` (
  `prestamo_id` int(50) NOT NULL,
  `prestamo_codigo` varchar(200) COLLATE utf8_spanish2_ci NOT NULL,
  `prestamo_fecha_inicio` date NOT NULL,
  `prestamo_hora_inicio` varchar(15) COLLATE utf8_spanish2_ci NOT NULL,
  `prestamo_fecha_final` date NOT NULL,
  `prestamo_hora_final` varchar(15) COLLATE utf8_spanish2_ci NOT NULL,
  `prestamo_cantidad` int(10) NOT NULL,
  `prestamo_total` decimal(30,2) NOT NULL,
  `prestamo_pagado` decimal(30,2) NOT NULL,
  `prestamo_estado` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `prestamo_observacion` varchar(535) COLLATE utf8_spanish2_ci NOT NULL,
  `usuario_id` int(10) NOT NULL,
  `cliente_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `prestamo`
--

INSERT INTO `prestamo` (`prestamo_id`, `prestamo_codigo`, `prestamo_fecha_inicio`, `prestamo_hora_inicio`, `prestamo_fecha_final`, `prestamo_hora_final`, `prestamo_cantidad`, `prestamo_total`, `prestamo_pagado`, `prestamo_estado`, `prestamo_observacion`, `usuario_id`, `cliente_id`) VALUES
(2, 'CP9522663-2', '2021-07-02', '03:00 pm', '2021-07-30', '03:02 pm', 2, '15844.00', '3432432.00', 'Reservacion', 'malo', 1, 1),
(4, 'CP9546948-2', '2021-07-03', '11:00 am', '2021-07-03', '12:01 pm', 10, '12.00', '7.00', 'Prestamo', 'BUENO', 1, 1),
(5, 'CP2373352-3', '2021-07-07', '03:20 pm', '2021-07-07', '03:23 pm', 12, '1728.00', '1728.00', 'Prestamo', 'Todo de acorde a lo que se requiere', 1, 1),
(6, 'CP9819350-4', '2021-07-14', '2021-07-14', '2021-07-14', '03:05 PM', 15, '3375.00', '3375.00', 'Finalizado', 'Préstamo pagado Totalmente', 1, 1),
(7, 'CP5013588-5', '2021-07-16', '2021-07-16', '2021-07-16', '04:05 PM', 36, '1944.00', '1000.00', 'Prestamo', 'ESTOS SON PRODUCTOS DE PLÁSTICO', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usuario_id` int(10) NOT NULL,
  `usuario_dni` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `usuario_nombre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `usuario_apellido` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `usuario_telefono` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `usuario_direccion` varchar(200) COLLATE utf8_spanish2_ci NOT NULL,
  `usuario_email` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `usuario_usuario` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `usuario_clave` varchar(535) COLLATE utf8_spanish2_ci NOT NULL,
  `usuario_estado` varchar(17) COLLATE utf8_spanish2_ci NOT NULL,
  `usuario_privilegio` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usuario_id`, `usuario_dni`, `usuario_nombre`, `usuario_apellido`, `usuario_telefono`, `usuario_direccion`, `usuario_email`, `usuario_usuario`, `usuario_clave`, `usuario_estado`, `usuario_privilegio`) VALUES
(1, '000000000000000000', 'Administrador', 'Principal', '918235458', 'Huaraz', 'admin@admin.com', 'Administrador', 'enJDK1NMbkJHbm1kZFZxbkxyNUhsQT09', 'Activa', 1),
(2, '72308749012', 'Jose Smit', 'Espinoza Miranda', '918235459', 'Huaraz', 'josesmit@gmail.com', 'JoseSmit', 'Yzh4T0JXSkc0dVNUUDA5Yy9GUEhmUT09', 'Activa', 2),
(3, '050501501511', 'Guillermo', 'Buenos Aires', '100200300', 'Argentina', 'guillermo@gmail.com', 'Guillermo', 'U05BUytBZDRRZzlQS2FJeWU4eEI4UT09', 'Activa', 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cliente_id`);

--
-- Indices de la tabla `detalle`
--
ALTER TABLE `detalle`
  ADD PRIMARY KEY (`detalle_id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `prestamo_codigo` (`prestamo_codigo`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`empresa_id`);

--
-- Indices de la tabla `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`item_id`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`pago_id`),
  ADD KEY `prestamo_codigo` (`prestamo_codigo`);

--
-- Indices de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD PRIMARY KEY (`prestamo_id`),
  ADD UNIQUE KEY `prestamo_codigo` (`prestamo_codigo`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usuario_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `cliente_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `detalle`
--
ALTER TABLE `detalle`
  MODIFY `detalle_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `empresa_id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `item`
--
ALTER TABLE `item`
  MODIFY `item_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `pago`
--
ALTER TABLE `pago`
  MODIFY `pago_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  MODIFY `prestamo_id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usuario_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle`
--
ALTER TABLE `detalle`
  ADD CONSTRAINT `detalle_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  ADD CONSTRAINT `detalle_ibfk_2` FOREIGN KEY (`prestamo_codigo`) REFERENCES `prestamo` (`prestamo_codigo`);

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `pago_ibfk_1` FOREIGN KEY (`prestamo_codigo`) REFERENCES `prestamo` (`prestamo_codigo`);

--
-- Filtros para la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`cliente_id`),
  ADD CONSTRAINT `prestamo_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`usuario_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
