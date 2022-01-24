import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/Cadres/CadresModel.dart';
import 'package:ccvc_mobile/presentation/add_cadres/bloc/add_cadres__state.dart';
import 'package:rxdart/rxdart.dart';

class AddCadresCubit extends BaseCubit<AddCadresState> {
  AddCadresCubit(AddCadresState initialState) : super(initialState);

  final BehaviorSubject<List<CadresModel>>_listCadres=
  BehaviorSubject<List<CadresModel>>();

  Stream<List<CadresModel>> get getListCadres => _listCadres.stream;


  void callAPI(){
     _listCadres.sink.add(fakeListCadres);
  }

   List<CadresModel>fakeListCadres=[
    CadresModel('1', 'VuDucHoa', 'GiamDoc'),
    CadresModel('1', 'VuDucHoa', 'GiamDoc'),
    CadresModel('1', 'VuDucHoa', 'GiamDoc'),
    CadresModel('1', 'VuDucHoa', 'GiamDoc'),
    CadresModel('1', 'VuDucHoa', 'GiamDoc'),
    CadresModel('1', 'VuDucHoa', 'GiamDoc')
  ];
}
