import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/admin/presentation/controllers/manage_destination_controller.dart';
import 'package:trekgo_project/src/feature/admin/presentation/views/update_place_screen.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_outlined_button.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

class AdminPlaceCard extends StatelessWidget {
  const AdminPlaceCard({
    super.key,
    required this.destination,
  });

  final DestinationEntity destination;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(destination.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkTeal,
                        ),
                      ),
                      const Gap(height: 5),
                      listItem(
                        text1: 'State',
                        text2: destination.state,
                      ),
                      const Gap(height: 3),
                      listItem(
                        text1: 'Category: ',
                        text2: destination.category,
                      ),
                      const Gap(height: 3),
                      listItem(
                        text1: 'Rating: ',
                        text2: '${destination.rating}',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Gap(height: 15),
          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  height: 45,
                  onPressed: () {
                    nextScreen(
                      context,
                      UpdatePlaceScreen(destination: destination),
                    );
                  },
                  text: 'Edit',
                ),
              ),
              const Gap(width: 10),
              Expanded(
                child: CustomOutlinedButton(
                  height: 45,
                  onPressed: () {
                    deleteDestination(destination.id, context);
                  },
                  text: 'Delete',
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Row listItem({required String text1, required String text2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(text2),
      ],
    );
  }

  Future<T?> deleteDestination<T>(String id, BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: 'Delete Place?',
          description: 'This place will be permanently deleted from this list',
          onTap: () async {
            Provider.of<ManageDestinationController>(context, listen: false)
                .deleteDestination(id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
