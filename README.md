# FUNCIONALIDADES DEL SISTEMA #

* Un proveedor tiene productos y los publica en el sitio.
 * Los productos tienen un nombre, una descripción, una imagen y un precio.
 * Poseen un estado de stock automático: disponible, no disponible.
 * Poseen un quiebre de precios por cantidad (5, 10, 15, 20, 25 unidades)
 * Poseen un precio especial por paquete cerrado.
* Un cliente puede hacer pedidos sobre los productos publicados.
 * El cliente va sumando productos al carrito
 * Una vez que completó el carrito, elige las cantidades y se calcula el precio final en función de las promociones vigentes.
 * El cliente confirma el pedido e ingresa información de envío, y el pedido queda en estado esperando pago.
 * El cliente realiza la transferencia bancaria y carga el comprobante asociado al pedido en cuestión.
 * El saldo se carga en la cuenta del cliente, y luego un vendedor lo consume para el pedido, el cual al estar pago pasa al estado preparado.
* Un cliente puede consultar su historial de pedidos.
 * El sistema calcula rebates automáticamente cada mes en función de los consumos realizados.
 * El sistema visualiza el rebate alcanzado hasta el momento, y cuánto falta para alcanzar el siguiente.
* Un cliente puede consultar la garantía de un producto que compró.
 * Cada producto comprado registra su número de serie
* Un cliente puede consultar su estado de cuenta.
 * Puede ver los movimientos de los últimos 60 días.
