abstract class IUseCase<Type, Params> {
  Type call(Params params);
}
