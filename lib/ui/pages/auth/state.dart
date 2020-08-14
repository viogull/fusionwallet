abstract class AccountCreationState {}

class AccountInitialState extends AccountCreationState {}

class AccountRecoveryState extends AccountCreationState {}

class AccountLockedState extends AccountCreationState {}

class PincodeCreationState extends AccountCreationState {}

class PassphraseCreationState extends AccountCreationState {}

class BiometricsConfigureState extends AccountCreationState {}

class AccountNamingState extends AccountCreationState {}

class CreatePincodeState extends AccountCreationState {}

class AccountUnlockedState extends AccountCreationState {}
