class ModelDelivery {
  int? id;
  String status;
  int driver_id;
  int order_id;
  ModelDelivery({
    this.id,
    required this.status,
    required this.driver_id,
    required this.order_id,
});
}