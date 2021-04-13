extension ListUtils<E> on List<E> {
  List<E> without(E itemToRemove) => where(
        (item) => item != itemToRemove,
      ).toList();
}
