// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'profile_event.dart';
// part 'profile_state.dart';

// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   ProfileBloc() : super(ProfileInitial());

//   @override
//   Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
//     if (event is FetchProfile) {
//       yield ProfileLoading();

//       try {
//         // Simulating a fetch operation (replace with your API or repository call)
//         final userProfile = await Future.delayed(
//           const Duration(seconds: 1),
//           () => {
//             "name": "John Doe",
//             "profilePic": null, // Replace with base64 data or null
//           },
//         );

//         yield ProfileLoaded(
//           name: userProfile["name"],
//           profilePic: userProfile["profilePic"],
//         );
//       } catch (e) {
//         yield ProfileError("Failed to load profile");
//       }
//     }
//   }
// }
