import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kafil/constants/constants.dart';
import 'package:kafil/core/services/app_validators.dart';
import 'package:kafil/core/widgets/avatar_image_widget.dart';
import 'package:kafil/core/widgets/checkbox_image_text_item.dart';
import 'package:kafil/core/widgets/chips_radio_options_widget.dart';
import 'package:kafil/core/widgets/editable_chip_field.dart';
import 'package:kafil/core/widgets/scrollable_fill_remaining_widget.dart';
import 'package:kafil/features/login/domain/entities/profile.dart';
import 'package:kafil/features/register/presentation/manager/register_provider.dart';
import 'package:kafil/features/register/presentation/widgets/salary_picker.dart';
import 'package:kafil/features/splash/domain/entities/app_dependencies.dart';

class ProfileWidget extends StatefulWidget {
  final AppDependencies appDependencies;
  final Profile? profile;
  final GlobalKey<FormState>? formKey;
  final TextEditingController? aboutController;
  final TextEditingController? birthDateController;

  const ProfileWidget({
    super.key,
    required this.appDependencies,
    this.profile,
    this.formKey,
    this.aboutController,
    this.birthDateController,
  });

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final _dateFormat = DateFormat('yyyy-MM-dd');
  late final TextEditingController _aboutController;
  late final TextEditingController _birthDateController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _aboutController = widget.aboutController ?? TextEditingController();
    _aboutController.text = widget.profile?.data?.about ?? '';

    _selectedDate = widget.profile?.data?.birthDate != null
        ? _dateFormat.parse(widget.profile!.data!.birthDate!)
        : null;

    _birthDateController =
        widget.birthDateController ?? TextEditingController();

    _birthDateController.text =
        _selectedDate != null ? _dateFormat.format(_selectedDate!) : '';
  }

  @override
  Widget build(BuildContext context) => _buildProfileInputs(context);

  Widget _buildProfileInputs(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ScrollableFillRemainingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AvatarImageWidget(
                avatarImageUrl: widget.profile?.data?.avatar,
                onImagePicked: _onAvatarImagePicked,
              ),
            ),
            const SizedBox(height: 16.0),
            _editableTextField(
              controller: _aboutController,
              label: kAboutString,
              readOnly: _aboutController.text.isNotEmpty,
              validator: AppValidators.aboutMeTextValidator,
            ),
            const SizedBox(height: 16.0),
            _salaryPickerSection(),
            const SizedBox(height: 16.0),
            _editableTextField(
              controller: _birthDateController,
              label: kBirthDateString,
              readOnly: true,
              maxLines: null,
              onTap: () => _selectDate(context),
              validator: AppValidators.fieldRequiredValidator,
              suffixIcon: Image.asset(kCalendarImage),
            ),
            const SizedBox(height: 16.0),
            _userTypeSection(),
            _genderSection(),
            const SizedBox(height: 16.0),
            _skillsSection(),
            const SizedBox(height: 16.0),
            _socialMediaSection(),
          ],
        ),
      ),
    );
  }

  Future<void> _onAvatarImagePicked(File? image) async {
    if (image != null) {
      context.read<RegisterProvider>().setAvatar(image);
    }
  }

  Widget _editableTextField({
    TextEditingController? controller,
    String? label,
    bool readOnly = false,
    int? maxLines = 1,
    void Function()? onTap,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      validator: validator,
      keyboardType: TextInputType.multiline,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffixIcon,
      ),
    );
  }

  Widget _salaryPickerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(kSalaryString, style: kDefaultTextStyle),
        const SizedBox(height: 8.0),
        SalaryPicker(
          salary: widget.profile?.data?.salary,
          onSalaryChanged: _onSalaryChanged,
        ),
      ],
    );
  }

  void _onSalaryChanged(int salary) {
    context.read<RegisterProvider>().setSalary(salary);
  }

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
        _birthDateController.text = _dateFormat.format(picked);
      });
    }
  }

  Widget _userTypeSection() {
    return widget.appDependencies.userTypes != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(kUserTypeString, style: kDefaultTextStyle),
              const SizedBox(height: 8.0),
              ChipsRadioOptionsWidget(
                options: widget.appDependencies.userTypes!
                    .map((e) => e.name ?? '')
                    .toList(),
                selectedIndex: (widget.profile?.data?.userType?.code ?? 1) - 1,
                onSelected: _onUserTypeSelected,
              ),
            ],
          )
        : const SizedBox();
  }

  void _onUserTypeSelected(int userType) {
    context.read<RegisterProvider>().setUserType(userType);
  }

  Widget _genderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(kGenderString, style: kDefaultTextStyle),
        const SizedBox(height: 8.0),
        ChipsRadioOptionsWidget(
          options: const [kMaleString, kFemaleString],
          selectedIndex: (widget.profile?.data?.gender ?? 1) - 1,
          onSelected: _onGenderSelected,
        ),
      ],
    );
  }

  void _onGenderSelected(int gender) {
    context.read<RegisterProvider>().setGender(gender);
  }

  Widget _skillsSection() {
    return EditableChipField(
      values:
          widget.appDependencies.skills?.map((e) => e.name ?? '').toList() ??
              [],
      labelText: kSkillsString,
      selectedValues:
          widget.profile?.data?.skills?.map((e) => e.name ?? '').toList(),
      onValuesChanged: _onSkillsChanged,
    );
  }

  void _onSkillsChanged(List<String> skills) {
    context.read<RegisterProvider>().setSkills(skills);
  }

  Widget _socialMediaSection() {
    var socialMediaList = widget.profile?.data?.favoriteSocialMedia ??
        widget.appDependencies.socialMedia?.map((e) => e.label ?? '') ??
        [];

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(kFavouriteSocialMediaString, style: kDefaultTextStyle),
        const SizedBox(height: 8.0),
        ...socialMediaList.map(
          (e) => CheckboxImageTextItem(
            text: e,
            image: getImageForSocialMedia(e.toLowerCase()),
            initiallyChecked: null,
            onSelected: _onSocialMediaItemSelected,
          ),
        ),
      ],
    );
  }

  void _onSocialMediaItemSelected(bool isSelected, String socialMediaItem) {
    if (isSelected) {
      context
          .read<RegisterProvider>()
          .addToFavoriteSocialMedia(socialMediaItem.toLowerCase());
    } else {
      context
          .read<RegisterProvider>()
          .removeFromFavoriteSocialMedia(socialMediaItem.toLowerCase());
    }
  }
}
