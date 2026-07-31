import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../utils/app_colors.dart';
import 'player_cv_screen.dart';
import '../../mock_players.dart';
import '../../models/player_model.dart';


//////////////////////////**search_state**//////////////////////////

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<PlayerModel> players;
  const SearchSuccess(this.players);

  @override
  List<Object?> get props => [players];
}

class SearchEmpty extends SearchState {}

//////////////////////////**search_cubit**//////////////////////////
class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  String searchQuery = '';
  Map<String, dynamic>? activeFilters;
  
  // Main search and filtering function
  void performSearch({required String selectedSport}) async {
    emit(SearchLoading());

    // Simulating a slight delay, as if fetching data from an API.
    await Future.delayed(const Duration(milliseconds: 300));

    final results = MockPlayers.bySport(selectedSport).where((player) {
      // 1. Mandatory Scouting Sports Filtering
      if (player.sport.trim().toLowerCase() != selectedSport.trim().toLowerCase()) {
        return false;
      }

      // 2. Text search
      final query = searchQuery.trim().toLowerCase();
      final matchesQuery = query.isEmpty ||
          player.name.toLowerCase().contains(query) ||
          player.club.toLowerCase().contains(query);

      if (activeFilters == null) return matchesQuery;

      // 3. The rest of the filters
      final selectedPos = activeFilters!['position'] as String?;
      final matchesPosition = selectedPos == null ||
          selectedPos.isEmpty ||
          player.position.toLowerCase().contains(selectedPos.toLowerCase());


      final minAge = activeFilters!['minAge'] ?? 12;
      final maxAge = activeFilters!['maxAge'] ?? 25;
      final matchesAge = player.age >= minAge && player.age <= maxAge;

      final minAi = activeFilters!['minAiScore'] ?? 50;
      final matchesAi = player.score >= minAi;

      bool matchesExp = true;
      final expStr = activeFilters!['experience'] as String?;
      if (expStr == '0-2 yrs') {
        matchesExp = player.experienceYears <= 2;
      } else if (expStr == '3-5 yrs') {
        matchesExp = player.experienceYears >= 3 && player.experienceYears <= 5;
      } else if (expStr == '+5 yrs') {
        matchesExp = player.experienceYears > 5;
      }

      return matchesQuery && matchesPosition && matchesAge && matchesAi && matchesExp;
    }).toList();

    if (results.isEmpty) {
      emit(SearchEmpty());
    } else {
      emit(SearchSuccess(results));
    }
  }

  // Reset search
  void resetSearch() {
    searchQuery = '';
    activeFilters = null;
    emit(SearchInitial());
  }
}
//////////////////////////**search_bar_widget**//////////////////////////

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted; 
  final VoidCallback onSearchPressed;

  const SearchBarWidget({
    Key? key,
    required this.onChanged,
    required this.onSubmitted,
    required this.onSearchPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      onSubmitted: onSubmitted, 
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        hintText: "Search by player name, club, or keyword...",
        hintStyle: const TextStyle(color: Colors.white70, fontSize: 13),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search, color: AppColors.blue),
          onPressed: onSearchPressed,
        ),
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}

//////////////////////////**filter_section_widget**//////////////////////////

class FilterSectionWidget extends StatefulWidget {
  final String scoutSport; 
  final Function(Map<String, dynamic>) onApplyFilters;
  final VoidCallback onReset;

  const FilterSectionWidget({
    Key? key,
    required this.scoutSport,
    required this.onApplyFilters,
    required this.onReset,
  }) : super(key: key);

  @override
  State<FilterSectionWidget> createState() => _FilterSectionWidgetState();
}

class _FilterSectionWidgetState extends State<FilterSectionWidget> {
  String? selectedPosition;
  RangeValues ageRange = const RangeValues(15, 23);
  double minAiScore = 70;
  String selectedExperience = '0-2 yrs';

    // The positions are linked to the type of sport.
    final Map<String, List<String>> positionsBySport = {
    'Football': ['Striker', 'Right Winger', 'Left Winger', 'Midfielder', 'Center Back' , 'Defender', 'Forward', 'Goalkeeper'],
    'Basketball': ['Point Guard', 'Shooting Guard', 'Center'],
    'Handball': ['Left Wing', 'Right Wing', 'Pivot', 'Goalkeeper'],
    'Volleyball': ['Outside Hitter','Opposite Hitter','Setter','Middle Blocker','Libero'],
  };

  final List<String> countries = ['Egypt', 'Saudi Arabia', 'UAE', 'Tunisia', 'Morocco'];
  final List<String> expOptions = ['0-2 yrs', '3-5 yrs', '+5 yrs'];

  @override
  Widget build(BuildContext context) {
    // Retrieve only the sports positions selected by the scout.
    final availablePositions = positionsBySport[widget.scoutSport] ?? [];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.blue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Filters", style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(color: Colors.white70, height: 20),

          // 1. Select position (varies by sport)
          _buildLabel("Position"),
          DropdownButtonFormField<String>(
            value: selectedPosition,
            hint: const Text("All Position", style: TextStyle(color: Colors.white70, fontSize: 13)),
            dropdownColor: AppColors.card,
            style: const TextStyle(color: AppColors.white),
            decoration: _inputDecoration(),
            items: availablePositions.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
            onChanged: (val) => setState(() => selectedPosition = val),
          ),
          const SizedBox(height: 12),

          // 2. Age Range Slider
          _buildLabel("Age Range: ${ageRange.start.round()} - ${ageRange.end.round()} yrs"),
          RangeSlider(
            values: ageRange,
            min: 12,
            max: 35,
            activeColor: AppColors.red,
            inactiveColor: AppColors.background,
            onChanged: (val) => setState(() => ageRange = val),
          ),

          // 3. AI Rating Slider
          _buildLabel("Min AI Score: ${minAiScore.round()}%+"),
          Slider(
            value: minAiScore,
            min: 50,
            max: 100,
            divisions: 10,
            activeColor: AppColors.blue,
            inactiveColor: AppColors.background,
            label: "${minAiScore.round()}%+",
            onChanged: (val) => setState(() => minAiScore = val),
          ),

          // 4. Years of Experience Options (Chips)
          _buildLabel("Experience Level"),
          Wrap(
            spacing: 8,
            children: expOptions.map((exp) {
              final isSelected = selectedExperience == exp;
              return ChoiceChip(
                label: Text(exp, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontSize: 12)),
                selected: isSelected,
                selectedColor: AppColors.red,
                backgroundColor: AppColors.background,
                onSelected: (selected) {
                  if (selected) setState(() => selectedExperience = exp);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // 5. Control buttons
          Row(
            children: [
              // Reset Button 
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white70,)),
                  onPressed: () {
                    setState(() {
                      selectedPosition = null;
                      ageRange = const RangeValues(15, 21);
                      minAiScore = 70;
                      selectedExperience = '';
                    });
                    widget.onReset();
                  },
                  child: const Text("Reset", style: TextStyle(color: Colors.white70,)),
                ),
              ),
              const SizedBox(width: 12),
              // Apply Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                  onPressed: () {
                    widget.onApplyFilters({
                      'position': selectedPosition,
                      'minAge': ageRange.start.round(),
                      'maxAge': ageRange.end.round(),
                      'minAiScore': minAiScore.round(),
                      'experience': selectedExperience,
                    });
                  },
                  child: const Text("Apply Filters", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 4),
      child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      filled: true,
      fillColor: AppColors.background,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    );
  }
}

//////////////////////////**player_card_widget**//////////////////////////

class PlayerCardWidget extends StatelessWidget {
  final String name;
  final int age;
  final String club;
  final String position;
  final int aiScore;
  final VoidCallback onViewProfile;

  const PlayerCardWidget({
    Key? key,
    required this.name,
    required this.age,
    required this.club,
    required this.position,
    required this.aiScore,
    required this.onViewProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.blue.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.background,
                child: Icon(Icons.person, size: 32, color: AppColors.blue),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(6)),
                  child: Text("$aiScore%", style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
          const SizedBox(width: 12),

          // Player Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text("$position • $age yrs", style: const TextStyle(color: AppColors.blue, fontSize: 12)),
                const SizedBox(height: 2),
                Text("$club ", style: const TextStyle(color: Colors.white70, fontSize: 11)),
              ],
            ),
          ),

          // View Profile Button 
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blue.withOpacity(0.15),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            ),
            onPressed: onViewProfile,
            child: const Text("View Profile", style: TextStyle(color: AppColors.blue, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class SearchPlayersScreen extends StatefulWidget {
  final String selectedSport;
  const SearchPlayersScreen({
    Key? key, 
    this.selectedSport = "Football",
  }) : super(key: key);

  @override
  State<SearchPlayersScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<SearchPlayersScreen> {
  bool isFilterExpanded = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<SearchCubit>();

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.card,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.white),
            title: Text("${widget.selectedSport} Search", style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(isFilterExpanded ? Icons.filter_list_off : Icons.filter_list, color: AppColors.red),
                onPressed: () => setState(() => isFilterExpanded = !isFilterExpanded),
              )
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Search Bar 
                SearchBarWidget(
                  onChanged: (text) => cubit.searchQuery = text,
                  onSubmitted: (_) => cubit.performSearch(selectedSport: widget.selectedSport),
                  onSearchPressed: () => cubit.performSearch(selectedSport: widget.selectedSport),
                ),
                const SizedBox(height: 16),
        
                // 2. Filters
                if (isFilterExpanded) ...[
                  FilterSectionWidget(
                    scoutSport: widget.selectedSport,
                    onApplyFilters: (filterData) {
                      cubit.activeFilters = filterData;
                      cubit.performSearch(selectedSport: widget.selectedSport);
                    },
                    onReset: () => cubit.resetSearch(),
                  ),
                  const SizedBox(height: 20),
                ],
        
                // 3. Results
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: CircularProgressIndicator(color: AppColors.blue),
                        ),
                      );
                    } else if (state is SearchEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Text("No players found matching your criteria.",
                              style: TextStyle(color: AppColors.red, fontSize: 14)),
                        ),
                      );
                    } else if (state is SearchSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Results (${state.players.length})",
                              style: const TextStyle(
                                  color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.players.length,
                            itemBuilder: (context, index) {
                              final player = state.players[index];
                              return PlayerCardWidget(
                                name: player.name,
                                age: player.age,
                                club: player.club,
                                position: player.position,
                                aiScore: player.score,
                                onViewProfile: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const PlayerCvScreen()),
                                  );
                                }, 
                              );
                            },
                          ),
                        ],
                      );
                    }
                    // Search Initial state
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Text("Type player name or set filters and press Apply",
                            style: TextStyle(color: Colors.white70, fontSize: 13)),
                      ),
                    );
                  },)
              ],
            ),
          ),
        );
      }
      )
    );
  }
}

