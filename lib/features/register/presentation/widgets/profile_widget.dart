import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/widgets/avatar_image_widget.dart';
import 'package:kafil/core/widgets/checkbox_image_text_item.dart';
import 'package:kafil/core/widgets/chips_radio_options_widget.dart';
import 'package:kafil/core/widgets/scrollable_fill_remaining_widget.dart';
import 'package:kafil/features/login/domain/entities/profile.dart';
import 'package:kafil/features/register/presentation/widgets/editable_chip_field.dart';
import 'package:kafil/features/register/presentation/widgets/salary_picker.dart';
import 'package:kafil/features/splash/domain/entities/app_dependencies.dart';

class ProfileWidget extends StatefulWidget {
  final AppDependencies appDependencies;
  final Profile? profile;

  const ProfileWidget({
    super.key,
    required this.appDependencies,
    required this.profile,
  });

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  late final TextEditingController _aboutController;
  late final TextEditingController _birthDateController;
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _aboutController = TextEditingController(text: widget.profile?.data?.about);
    _birthDateController = TextEditingController(
      text: widget.profile?.data?.birthDate ??
          (_selectedDate != null ? _dateFormat.format(_selectedDate!) : ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableFillRemainingWidget(
      child: Column(
        children: [
          AvatarImageWidget(
            avatarImageUrl: widget.profile?.data?.avatar,
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _aboutController,
            readOnly: widget.profile?.data?.about != null,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(labelText: kAboutString),
          ),
          const SizedBox(height: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  kSalaryString,
                  style: kDefaultTextStyle,
                ),
              ),
              const SizedBox(height: 8.0),
              SalaryPicker(
                salary: widget.profile?.data?.salary,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          TextField(
            readOnly: true,
            onTap: widget.profile?.data?.birthDate != null
                ? null
                : () => _selectDate(context),
            controller: _birthDateController,
            decoration: InputDecoration(
              labelText: kBirthDateString,
              suffixIcon: Image.asset(kCalendarImage),
            ),
          ),
          const SizedBox(height: 16.0),
          widget.appDependencies.userTypes != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        kUserTypeString,
                        style: kDefaultTextStyle,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: double.maxFinite,
                      child: ChipsRadioOptionsWidget(
                        options: widget.appDependencies.userTypes!
                            .map((e) => e.name ?? '')
                            .toList(),
                        selectedIndex: widget.profile?.data?.userType?.code,
                        onSelected: null,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                )
              : const SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  kGenderString,
                  style: kDefaultTextStyle,
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: double.maxFinite,
                child: ChipsRadioOptionsWidget(
                  options: const ['Male', 'Female'],
                  selectedIndex: widget.profile?.data?.gender,
                  onSelected: null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          EditableChipField(
            values: widget.appDependencies.skills
                    ?.map((e) => e.name ?? '')
                    .toList() ??
                [],
            labelText: kSkillsString,
            onValuesChanged: null,
            selectedValues:
                widget.profile?.data?.skills?.map((e) => e.name ?? '').toList(),
          ),
          const SizedBox(height: 16.0),
          widget.profile?.data?.favoriteSocialMedia != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kFavouriteSocialMediaString,
                      style: kDefaultTextStyle,
                    ),
                    const SizedBox(height: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.profile?.data?.favoriteSocialMedia!
                              .map(
                                (e) => CheckboxImageTextItem(
                                  text: e,
                                  image:
                                      getImageForSocialMedia(e.toLowerCase()),
                                  initiallyChecked: true,
                                ),
                              )
                              .toList() ??
                          [],
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kFavouriteSocialMediaString,
                      style: kDefaultTextStyle,
                    ),
                    const SizedBox(height: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.appDependencies.socialMedia != null
                          ? widget.appDependencies.socialMedia!
                              .map(
                                (e) => CheckboxImageTextItem(
                                  text: e.label ?? '',
                                  image: getImageForSocialMedia(
                                      e.label?.toLowerCase() ?? ''),
                                ),
                              )
                              .toList()
                          : [],
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  String getImageForSocialMedia(String name) {
    switch (name) {
      case String a when a.contains('linkedin'):
        return kLinkedinImage;
      case String a when a.contains('x'):
        return kXImage;
      case String a when a.contains('instagram'):
        return kInstagramImage;
      default:
        return kFacebookImage;
    }
  }
}
