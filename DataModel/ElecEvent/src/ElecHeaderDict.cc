//
// File generated by /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/ROOT/5.34.11/bin/rootcint at Thu Dec 28 13:43:47 2017

// Do NOT change. Changes will be lost next time file is generated
//

#define R__DICTIONARY_FILENAME dOdOdIsrcdIElecHeaderDict
#include "RConfig.h" //rootcint 4834
#if !defined(R__ACCESS_IN_SYMBOL)
//Break the privacy of classes -- Disabled for the moment
#define private public
#define protected public
#endif

// Since CINT ignores the std namespace, we need to do so in this file.
namespace std {} using namespace std;
#include "ElecHeaderDict.h"

#include "TClass.h"
#include "TBuffer.h"
#include "TMemberInspector.h"
#include "TError.h"

#ifndef G__ROOT
#define G__ROOT
#endif

#include "RtypesImp.h"
#include "TIsAProxy.h"
#include "TFileMergeInfo.h"

// Direct notice to TROOT of the dictionary's loading.
namespace {
   static struct DictInit {
      DictInit() {
         ROOT::RegisterModule();
      }
   } __TheDictionaryInitializer;
}

// START OF SHADOWS

namespace ROOT {
   namespace Shadow {
   } // of namespace Shadow
} // of namespace ROOT
// END OF SHADOWS

namespace ROOT {
   void JMcLcLElecHeader_ShowMembers(void *obj, TMemberInspector &R__insp);
   static void *new_JMcLcLElecHeader(void *p = 0);
   static void *newArray_JMcLcLElecHeader(Long_t size, void *p);
   static void delete_JMcLcLElecHeader(void *p);
   static void deleteArray_JMcLcLElecHeader(void *p);
   static void destruct_JMcLcLElecHeader(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::JM::ElecHeader*)
   {
      ::JM::ElecHeader *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TInstrumentedIsAProxy< ::JM::ElecHeader >(0);
      static ::ROOT::TGenericClassInfo 
         instance("JM::ElecHeader", ::JM::ElecHeader::Class_Version(), "./ElecHeader.h", 41,
                  typeid(::JM::ElecHeader), DefineBehavior(ptr, ptr),
                  &::JM::ElecHeader::Dictionary, isa_proxy, 4,
                  sizeof(::JM::ElecHeader) );
      instance.SetNew(&new_JMcLcLElecHeader);
      instance.SetNewArray(&newArray_JMcLcLElecHeader);
      instance.SetDelete(&delete_JMcLcLElecHeader);
      instance.SetDeleteArray(&deleteArray_JMcLcLElecHeader);
      instance.SetDestructor(&destruct_JMcLcLElecHeader);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::JM::ElecHeader*)
   {
      return GenerateInitInstanceLocal((::JM::ElecHeader*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::JM::ElecHeader*)0x0); R__UseDummy(_R__UNIQUE_(Init));
} // end of namespace ROOT

      namespace JM {
//______________________________________________________________________________
TClass *ElecHeader::fgIsA = 0;  // static to hold class pointer

//______________________________________________________________________________
const char *ElecHeader::Class_Name()
{
   return "JM::ElecHeader";
}

//______________________________________________________________________________
const char *ElecHeader::ImplFileName()
{
   return ::ROOT::GenerateInitInstanceLocal((const ::JM::ElecHeader*)0x0)->GetImplFileName();
}

//______________________________________________________________________________
int ElecHeader::ImplFileLine()
{
   return ::ROOT::GenerateInitInstanceLocal((const ::JM::ElecHeader*)0x0)->GetImplFileLine();
}

//______________________________________________________________________________
void ElecHeader::Dictionary()
{
   fgIsA = ::ROOT::GenerateInitInstanceLocal((const ::JM::ElecHeader*)0x0)->GetClass();
}

//______________________________________________________________________________
TClass *ElecHeader::Class()
{
   if (!fgIsA) fgIsA = ::ROOT::GenerateInitInstanceLocal((const ::JM::ElecHeader*)0x0)->GetClass();
   return fgIsA;
}

} // namespace JM
      namespace JM {
//______________________________________________________________________________
void ElecHeader::Streamer(TBuffer &R__b)
{
   // Stream an object of class JM::ElecHeader.

   if (R__b.IsReading()) {
      R__b.ReadClassBuffer(JM::ElecHeader::Class(),this);
   } else {
      R__b.WriteClassBuffer(JM::ElecHeader::Class(),this);
   }
}

} // namespace JM
//______________________________________________________________________________
      namespace JM {
void ElecHeader::ShowMembers(TMemberInspector &R__insp)
{
      // Inspect the data members of an object of class JM::ElecHeader.
      TClass *R__cl = ::JM::ElecHeader::IsA();
      if (R__cl || R__insp.IsA()) { }
      R__insp.Inspect(R__cl, R__insp.GetParent(), "m_event", &m_event);
      R__insp.InspectMember(m_event, "m_event.");
      R__insp.Inspect(R__cl, R__insp.GetParent(), "m_spmtEvent", &m_spmtEvent);
      R__insp.InspectMember(m_spmtEvent, "m_spmtEvent.");
      //This works around a msvc bug and should be harmless on other platforms
      typedef JM::HeaderObject baseClass1;
      baseClass1::ShowMembers(R__insp);
}

} // namespace JM
namespace ROOT {
   // Wrappers around operator new
   static void *new_JMcLcLElecHeader(void *p) {
      return  p ? new(p) ::JM::ElecHeader : new ::JM::ElecHeader;
   }
   static void *newArray_JMcLcLElecHeader(Long_t nElements, void *p) {
      return p ? new(p) ::JM::ElecHeader[nElements] : new ::JM::ElecHeader[nElements];
   }
   // Wrapper around operator delete
   static void delete_JMcLcLElecHeader(void *p) {
      delete ((::JM::ElecHeader*)p);
   }
   static void deleteArray_JMcLcLElecHeader(void *p) {
      delete [] ((::JM::ElecHeader*)p);
   }
   static void destruct_JMcLcLElecHeader(void *p) {
      typedef ::JM::ElecHeader current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::JM::ElecHeader

/********************************************************
* ../src/ElecHeaderDict.cc
* CAUTION: DON'T CHANGE THIS FILE. THIS FILE IS AUTOMATICALLY GENERATED
*          FROM HEADER FILES LISTED IN G__setup_cpp_environmentXXX().
*          CHANGE THOSE HEADER FILES AND REGENERATE THIS FILE.
********************************************************/

#ifdef G__MEMTEST
#undef malloc
#undef free
#endif

#if defined(__GNUC__) && __GNUC__ >= 4 && ((__GNUC_MINOR__ == 2 && __GNUC_PATCHLEVEL__ >= 1) || (__GNUC_MINOR__ >= 3))
#pragma GCC diagnostic ignored "-Wstrict-aliasing"
#endif

extern "C" void G__cpp_reset_tagtableElecHeaderDict();

extern "C" void G__set_cpp_environmentElecHeaderDict() {
  G__add_compiledheader("TObject.h");
  G__add_compiledheader("TMemberInspector.h");
  G__add_compiledheader("ElecHeader.h");
  G__cpp_reset_tagtableElecHeaderDict();
}
#include <new>
extern "C" int G__cpp_dllrevElecHeaderDict() { return(30051515); }

/*********************************************************
* Member function Interface Method
*********************************************************/

/* JM::ElecHeader */
static int G__ElecHeaderDict_429_0_1(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
   JM::ElecHeader* p = NULL;
   char* gvp = (char*) G__getgvp();
   int n = G__getaryconstruct();
   if (n) {
     if ((gvp == (char*)G__PVOID) || (gvp == 0)) {
       p = new JM::ElecHeader[n];
     } else {
       p = new((void*) gvp) JM::ElecHeader[n];
     }
   } else {
     if ((gvp == (char*)G__PVOID) || (gvp == 0)) {
       p = new JM::ElecHeader;
     } else {
       p = new((void*) gvp) JM::ElecHeader;
     }
   }
   result7->obj.i = (long) p;
   result7->ref = (long) p;
   G__set_tagnum(result7,G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLElecHeader));
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_2(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 85, (long) ((JM::ElecHeader*) G__getstructoffset())->event());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_3(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      ((JM::ElecHeader*) G__getstructoffset())->setEvent((JM::ElecEvent*) G__int(libp->para[0]));
      G__setnull(result7);
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_4(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 85, (long) ((JM::ElecHeader*) G__getstructoffset())->spmtEvent());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_5(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      ((JM::ElecHeader*) G__getstructoffset())->setSpmtEvent((JM::SpmtElecEvent*) G__int(libp->para[0]));
      G__setnull(result7);
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_8(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 103, (long) ((JM::ElecHeader*) G__getstructoffset())->hasEvent());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_9(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 103, (long) ((JM::ElecHeader*) G__getstructoffset())->hasSpmtEvent());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_10(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 85, (long) JM::ElecHeader::Class());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_11(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 67, (long) JM::ElecHeader::Class_Name());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_12(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 115, (long) JM::ElecHeader::Class_Version());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_13(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      JM::ElecHeader::Dictionary();
      G__setnull(result7);
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_17(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      ((JM::ElecHeader*) G__getstructoffset())->StreamerNVirtual(*(TBuffer*) libp->para[0].ref);
      G__setnull(result7);
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_18(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 67, (long) JM::ElecHeader::DeclFileName());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_19(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 105, (long) JM::ElecHeader::ImplFileLine());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_20(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 67, (long) JM::ElecHeader::ImplFileName());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__ElecHeaderDict_429_0_21(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 105, (long) JM::ElecHeader::DeclFileLine());
   return(1 || funcname || hash || result7 || libp) ;
}

// automatic copy constructor
static int G__ElecHeaderDict_429_0_22(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)

{
   JM::ElecHeader* p;
   void* tmp = (void*) G__int(libp->para[0]);
   p = new JM::ElecHeader(*(JM::ElecHeader*) tmp);
   result7->obj.i = (long) p;
   result7->ref = (long) p;
   G__set_tagnum(result7,G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLElecHeader));
   return(1 || funcname || hash || result7 || libp) ;
}

// automatic destructor
typedef JM::ElecHeader G__TJMcLcLElecHeader;
static int G__ElecHeaderDict_429_0_23(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
   char* gvp = (char*) G__getgvp();
   long soff = G__getstructoffset();
   int n = G__getaryconstruct();
   //
   //has_a_delete: 1
   //has_own_delete1arg: 0
   //has_own_delete2arg: 0
   //
   if (!soff) {
     return(1);
   }
   if (n) {
     if (gvp == (char*)G__PVOID) {
       delete[] (JM::ElecHeader*) soff;
     } else {
       G__setgvp((long) G__PVOID);
       for (int i = n - 1; i >= 0; --i) {
         ((JM::ElecHeader*) (soff+(sizeof(JM::ElecHeader)*i)))->~G__TJMcLcLElecHeader();
       }
       G__setgvp((long)gvp);
     }
   } else {
     if (gvp == (char*)G__PVOID) {
       delete (JM::ElecHeader*) soff;
     } else {
       G__setgvp((long) G__PVOID);
       ((JM::ElecHeader*) (soff))->~G__TJMcLcLElecHeader();
       G__setgvp((long)gvp);
     }
   }
   G__setnull(result7);
   return(1 || funcname || hash || result7 || libp) ;
}

// automatic assignment operator
static int G__ElecHeaderDict_429_0_24(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
   JM::ElecHeader* dest = (JM::ElecHeader*) G__getstructoffset();
   *dest = *(JM::ElecHeader*) libp->para[0].ref;
   const JM::ElecHeader& obj = *dest;
   result7->ref = (long) (&obj);
   result7->obj.i = (long) (&obj);
   return(1 || funcname || hash || result7 || libp) ;
}


/* Setting up global function */

/*********************************************************
* Member function Stub
*********************************************************/

/* JM::ElecHeader */

/*********************************************************
* Global function Stub
*********************************************************/

/*********************************************************
* Get size of pointer to member function
*********************************************************/
class G__Sizep2memfuncElecHeaderDict {
 public:
  G__Sizep2memfuncElecHeaderDict(): p(&G__Sizep2memfuncElecHeaderDict::sizep2memfunc) {}
    size_t sizep2memfunc() { return(sizeof(p)); }
  private:
    size_t (G__Sizep2memfuncElecHeaderDict::*p)();
};

size_t G__get_sizep2memfuncElecHeaderDict()
{
  G__Sizep2memfuncElecHeaderDict a;
  G__setsizep2memfunc((int)a.sizep2memfunc());
  return((size_t)a.sizep2memfunc());
}


/*********************************************************
* virtual base class offset calculation interface
*********************************************************/

   /* Setting up class inheritance */

/*********************************************************
* Inheritance information setup/
*********************************************************/
extern "C" void G__cpp_setup_inheritanceElecHeaderDict() {

   /* Setting up class inheritance */
   if(0==G__getnumbaseclass(G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLElecHeader))) {
     JM::ElecHeader *G__Lderived;
     G__Lderived=(JM::ElecHeader*)0x1000;
     {
       JM::HeaderObject *G__Lpbase=(JM::HeaderObject*)G__Lderived;
       G__inheritance_setup(G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLElecHeader),G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLHeaderObject),(long)G__Lpbase-(long)G__Lderived,1,1);
     }
     {
       JM::EventObject *G__Lpbase=(JM::EventObject*)G__Lderived;
       G__inheritance_setup(G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLElecHeader),G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLEventObject),(long)G__Lpbase-(long)G__Lderived,1,0);
     }
     {
       TObject *G__Lpbase=(TObject*)G__Lderived;
       G__inheritance_setup(G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLElecHeader),G__get_linked_tagnum(&G__ElecHeaderDictLN_TObject),(long)G__Lpbase-(long)G__Lderived,1,0);
     }
   }
}

/*********************************************************
* typedef information setup/
*********************************************************/
extern "C" void G__cpp_setup_typetableElecHeaderDict() {

   /* Setting up typedef entry */
   G__search_typename2("Version_t",115,-1,0,-1);
   G__setnewtype(-1,"Class version identifier (short)",0);
   G__search_typename2("vector<ROOT::TSchemaHelper>",117,G__get_linked_tagnum(&G__ElecHeaderDictLN_vectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgR),0,-1);
   G__setnewtype(-1,NULL,0);
   G__search_typename2("reverse_iterator<const_iterator>",117,G__get_linked_tagnum(&G__ElecHeaderDictLN_reverse_iteratorlEvectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgRcLcLiteratorgR),0,G__get_linked_tagnum(&G__ElecHeaderDictLN_vectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgR));
   G__setnewtype(-1,NULL,0);
   G__search_typename2("reverse_iterator<iterator>",117,G__get_linked_tagnum(&G__ElecHeaderDictLN_reverse_iteratorlEvectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgRcLcLiteratorgR),0,G__get_linked_tagnum(&G__ElecHeaderDictLN_vectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgR));
   G__setnewtype(-1,NULL,0);
   G__search_typename2("vector<TVirtualArray*>",117,G__get_linked_tagnum(&G__ElecHeaderDictLN_vectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgR),0,-1);
   G__setnewtype(-1,NULL,0);
   G__search_typename2("reverse_iterator<const_iterator>",117,G__get_linked_tagnum(&G__ElecHeaderDictLN_reverse_iteratorlEvectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgRcLcLiteratorgR),0,G__get_linked_tagnum(&G__ElecHeaderDictLN_vectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgR));
   G__setnewtype(-1,NULL,0);
   G__search_typename2("reverse_iterator<iterator>",117,G__get_linked_tagnum(&G__ElecHeaderDictLN_reverse_iteratorlEvectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgRcLcLiteratorgR),0,G__get_linked_tagnum(&G__ElecHeaderDictLN_vectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgR));
   G__setnewtype(-1,NULL,0);
   G__search_typename2("map<int,JM::ElecFeeChannel>",117,G__get_linked_tagnum(&G__ElecHeaderDictLN_maplEintcOJMcLcLElecFeeChannelcOlesslEintgRcOallocatorlEpairlEconstsPintcOJMcLcLElecFeeChannelgRsPgRsPgR),0,-1);
   G__setnewtype(-1,NULL,0);
   G__search_typename2("map<int,JM::ElecFeeChannel,less<int> >",117,G__get_linked_tagnum(&G__ElecHeaderDictLN_maplEintcOJMcLcLElecFeeChannelcOlesslEintgRcOallocatorlEpairlEconstsPintcOJMcLcLElecFeeChannelgRsPgRsPgR),0,-1);
   G__setnewtype(-1,NULL,0);
   G__search_typename2("vector<int>",117,G__get_linked_tagnum(&G__ElecHeaderDictLN_vectorlEintcOallocatorlEintgRsPgR),0,-1);
   G__setnewtype(-1,NULL,0);
   G__search_typename2("reverse_iterator<const_iterator>",117,G__get_linked_tagnum(&G__ElecHeaderDictLN_reverse_iteratorlEvectorlEintcOallocatorlEintgRsPgRcLcLiteratorgR),0,G__get_linked_tagnum(&G__ElecHeaderDictLN_vectorlEintcOallocatorlEintgRsPgR));
   G__setnewtype(-1,NULL,0);
   G__search_typename2("reverse_iterator<iterator>",117,G__get_linked_tagnum(&G__ElecHeaderDictLN_reverse_iteratorlEvectorlEintcOallocatorlEintgRsPgRcLcLiteratorgR),0,G__get_linked_tagnum(&G__ElecHeaderDictLN_vectorlEintcOallocatorlEintgRsPgR));
   G__setnewtype(-1,NULL,0);
   G__search_typename2("vector<JM::SpmtElecAbcBlock>",117,G__get_linked_tagnum(&G__ElecHeaderDictLN_vectorlEJMcLcLSpmtElecAbcBlockcOallocatorlEJMcLcLSpmtElecAbcBlockgRsPgR),0,-1);
   G__setnewtype(-1,NULL,0);
   G__search_typename2("reverse_iterator<const_iterator>",117,G__get_linked_tagnum(&G__ElecHeaderDictLN_reverse_iteratorlEvectorlEJMcLcLSpmtElecAbcBlockcOallocatorlEJMcLcLSpmtElecAbcBlockgRsPgRcLcLiteratorgR),0,G__get_linked_tagnum(&G__ElecHeaderDictLN_vectorlEJMcLcLSpmtElecAbcBlockcOallocatorlEJMcLcLSpmtElecAbcBlockgRsPgR));
   G__setnewtype(-1,NULL,0);
   G__search_typename2("reverse_iterator<iterator>",117,G__get_linked_tagnum(&G__ElecHeaderDictLN_reverse_iteratorlEvectorlEJMcLcLSpmtElecAbcBlockcOallocatorlEJMcLcLSpmtElecAbcBlockgRsPgRcLcLiteratorgR),0,G__get_linked_tagnum(&G__ElecHeaderDictLN_vectorlEJMcLcLSpmtElecAbcBlockcOallocatorlEJMcLcLSpmtElecAbcBlockgRsPgR));
   G__setnewtype(-1,NULL,0);
}

/*********************************************************
* Data Member information setup/
*********************************************************/

   /* Setting up class,struct,union tag member variable */

   /* JM::ElecHeader */
static void G__setup_memvarJMcLcLElecHeader(void) {
   G__tag_memvar_setup(G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLElecHeader));
   { JM::ElecHeader *p; p=(JM::ElecHeader*)0x1000; if (p) { }
   G__memvar_setup((void*)0,117,0,0,G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLSmartRef),-1,-1,4,"m_event=",0,"||SmartRef to the Elec Event");
   G__memvar_setup((void*)0,117,0,0,G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLSmartRef),-1,-1,4,"m_spmtEvent=",0,"||SmartRef to the SPMT Elec Event");
   G__memvar_setup((void*)0,85,0,0,G__get_linked_tagnum(&G__ElecHeaderDictLN_TClass),-1,-2,4,"fgIsA=",0,(char*)NULL);
   }
   G__tag_memvar_reset();
}

extern "C" void G__cpp_setup_memvarElecHeaderDict() {
}
/***********************************************************
************************************************************
************************************************************
************************************************************
************************************************************
************************************************************
************************************************************
***********************************************************/

/*********************************************************
* Member function information setup for each class
*********************************************************/
static void G__setup_memfuncJMcLcLElecHeader(void) {
   /* JM::ElecHeader */
   G__tag_memfunc_setup(G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLElecHeader));
   G__memfunc_setup("ElecHeader",962,G__ElecHeaderDict_429_0_1, 105, G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLElecHeader), -1, 0, 0, 1, 1, 0, "", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("event",546,G__ElecHeaderDict_429_0_2, 85, G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLElecEvent), -1, 0, 0, 1, 1, 0, "", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("setEvent",846,G__ElecHeaderDict_429_0_3, 121, -1, -1, 0, 1, 1, 1, 0, "U 'JM::ElecEvent' - 0 - value", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("spmtEvent",966,G__ElecHeaderDict_429_0_4, 85, G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLSpmtElecEvent), -1, 0, 0, 1, 1, 0, "", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("setSpmtEvent",1266,G__ElecHeaderDict_429_0_5, 121, -1, -1, 0, 1, 1, 1, 0, "U 'JM::SpmtElecEvent' - 0 - value", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("setEventEntry",1376,(G__InterfaceMethod) NULL,121, -1, -1, 0, 2, 1, 1, 0, 
"u 'string' - 11 - eventName n - 'Long64_t' 1 - value", (char*)NULL, (void*) NULL, 1);
   G__memfunc_setup("event",546,(G__InterfaceMethod) NULL,85, G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLEventObject), -1, 0, 1, 1, 1, 0, "u 'string' - 11 - eventName", (char*)NULL, (void*) NULL, 1);
   G__memfunc_setup("hasEvent",830,G__ElecHeaderDict_429_0_8, 103, -1, -1, 0, 0, 1, 1, 0, "", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("hasSpmtEvent",1250,G__ElecHeaderDict_429_0_9, 103, -1, -1, 0, 0, 1, 1, 0, "", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("Class",502,G__ElecHeaderDict_429_0_10, 85, G__get_linked_tagnum(&G__ElecHeaderDictLN_TClass), -1, 0, 0, 3, 1, 0, "", (char*)NULL, (void*) G__func2void( (TClass* (*)())(&JM::ElecHeader::Class) ), 0);
   G__memfunc_setup("Class_Name",982,G__ElecHeaderDict_429_0_11, 67, -1, -1, 0, 0, 3, 1, 1, "", (char*)NULL, (void*) G__func2void( (const char* (*)())(&JM::ElecHeader::Class_Name) ), 0);
   G__memfunc_setup("Class_Version",1339,G__ElecHeaderDict_429_0_12, 115, -1, G__defined_typename("Version_t"), 0, 0, 3, 1, 0, "", (char*)NULL, (void*) G__func2void( (Version_t (*)())(&JM::ElecHeader::Class_Version) ), 0);
   G__memfunc_setup("Dictionary",1046,G__ElecHeaderDict_429_0_13, 121, -1, -1, 0, 0, 3, 1, 0, "", (char*)NULL, (void*) G__func2void( (void (*)())(&JM::ElecHeader::Dictionary) ), 0);
   G__memfunc_setup("IsA",253,(G__InterfaceMethod) NULL,85, G__get_linked_tagnum(&G__ElecHeaderDictLN_TClass), -1, 0, 0, 1, 1, 8, "", (char*)NULL, (void*) NULL, 1);
   G__memfunc_setup("ShowMembers",1132,(G__InterfaceMethod) NULL,121, -1, -1, 0, 1, 1, 1, 0, "u 'TMemberInspector' - 1 - -", (char*)NULL, (void*) NULL, 1);
   G__memfunc_setup("Streamer",835,(G__InterfaceMethod) NULL,121, -1, -1, 0, 1, 1, 1, 0, "u 'TBuffer' - 1 - -", (char*)NULL, (void*) NULL, 1);
   G__memfunc_setup("StreamerNVirtual",1656,G__ElecHeaderDict_429_0_17, 121, -1, -1, 0, 1, 1, 1, 0, "u 'TBuffer' - 1 - ClassDef_StreamerNVirtual_b", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("DeclFileName",1145,G__ElecHeaderDict_429_0_18, 67, -1, -1, 0, 0, 3, 1, 1, "", (char*)NULL, (void*) G__func2void( (const char* (*)())(&JM::ElecHeader::DeclFileName) ), 0);
   G__memfunc_setup("ImplFileLine",1178,G__ElecHeaderDict_429_0_19, 105, -1, -1, 0, 0, 3, 1, 0, "", (char*)NULL, (void*) G__func2void( (int (*)())(&JM::ElecHeader::ImplFileLine) ), 0);
   G__memfunc_setup("ImplFileName",1171,G__ElecHeaderDict_429_0_20, 67, -1, -1, 0, 0, 3, 1, 1, "", (char*)NULL, (void*) G__func2void( (const char* (*)())(&JM::ElecHeader::ImplFileName) ), 0);
   G__memfunc_setup("DeclFileLine",1152,G__ElecHeaderDict_429_0_21, 105, -1, -1, 0, 0, 3, 1, 0, "", (char*)NULL, (void*) G__func2void( (int (*)())(&JM::ElecHeader::DeclFileLine) ), 0);
   // automatic copy constructor
   G__memfunc_setup("ElecHeader", 962, G__ElecHeaderDict_429_0_22, (int) ('i'), G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLElecHeader), -1, 0, 1, 1, 1, 0, "u 'JM::ElecHeader' - 11 - -", (char*) NULL, (void*) NULL, 0);
   // automatic destructor
   G__memfunc_setup("~ElecHeader", 1088, G__ElecHeaderDict_429_0_23, (int) ('y'), -1, -1, 0, 0, 1, 1, 0, "", (char*) NULL, (void*) NULL, 1);
   // automatic assignment operator
   G__memfunc_setup("operator=", 937, G__ElecHeaderDict_429_0_24, (int) ('u'), G__get_linked_tagnum(&G__ElecHeaderDictLN_JMcLcLElecHeader), -1, 1, 1, 1, 1, 0, "u 'JM::ElecHeader' - 11 - -", (char*) NULL, (void*) NULL, 0);
   G__tag_memfunc_reset();
}


/*********************************************************
* Member function information setup
*********************************************************/
extern "C" void G__cpp_setup_memfuncElecHeaderDict() {
}

/*********************************************************
* Global variable information setup for each class
*********************************************************/
static void G__cpp_setup_global0() {

   /* Setting up global variables */
   G__resetplocal();

}

static void G__cpp_setup_global1() {

   G__resetglobalenv();
}
extern "C" void G__cpp_setup_globalElecHeaderDict() {
  G__cpp_setup_global0();
  G__cpp_setup_global1();
}

/*********************************************************
* Global function information setup for each class
*********************************************************/
static void G__cpp_setup_func0() {
   G__lastifuncposition();

}

static void G__cpp_setup_func1() {
}

static void G__cpp_setup_func2() {
}

static void G__cpp_setup_func3() {
}

static void G__cpp_setup_func4() {
}

static void G__cpp_setup_func5() {
}

static void G__cpp_setup_func6() {
}

static void G__cpp_setup_func7() {
}

static void G__cpp_setup_func8() {
}

static void G__cpp_setup_func9() {
}

static void G__cpp_setup_func10() {
}

static void G__cpp_setup_func11() {
}

static void G__cpp_setup_func12() {
}

static void G__cpp_setup_func13() {
}

static void G__cpp_setup_func14() {
}

static void G__cpp_setup_func15() {
}

static void G__cpp_setup_func16() {
}

static void G__cpp_setup_func17() {
}

static void G__cpp_setup_func18() {

   G__resetifuncposition();
}

extern "C" void G__cpp_setup_funcElecHeaderDict() {
  G__cpp_setup_func0();
  G__cpp_setup_func1();
  G__cpp_setup_func2();
  G__cpp_setup_func3();
  G__cpp_setup_func4();
  G__cpp_setup_func5();
  G__cpp_setup_func6();
  G__cpp_setup_func7();
  G__cpp_setup_func8();
  G__cpp_setup_func9();
  G__cpp_setup_func10();
  G__cpp_setup_func11();
  G__cpp_setup_func12();
  G__cpp_setup_func13();
  G__cpp_setup_func14();
  G__cpp_setup_func15();
  G__cpp_setup_func16();
  G__cpp_setup_func17();
  G__cpp_setup_func18();
}

/*********************************************************
* Class,struct,union,enum tag information setup
*********************************************************/
/* Setup class/struct taginfo */
G__linked_taginfo G__ElecHeaderDictLN_TClass = { "TClass" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_TBuffer = { "TBuffer" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_TMemberInspector = { "TMemberInspector" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_TObject = { "TObject" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_string = { "string" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_vectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgR = { "vector<ROOT::TSchemaHelper,allocator<ROOT::TSchemaHelper> >" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_reverse_iteratorlEvectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgRcLcLiteratorgR = { "reverse_iterator<vector<ROOT::TSchemaHelper,allocator<ROOT::TSchemaHelper> >::iterator>" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_vectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgR = { "vector<TVirtualArray*,allocator<TVirtualArray*> >" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_reverse_iteratorlEvectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgRcLcLiteratorgR = { "reverse_iterator<vector<TVirtualArray*,allocator<TVirtualArray*> >::iterator>" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_JM = { "JM" , 110 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_JMcLcLEventObject = { "JM::EventObject" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_JMcLcLHeaderObject = { "JM::HeaderObject" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_maplEintcOJMcLcLElecFeeChannelcOlesslEintgRcOallocatorlEpairlEconstsPintcOJMcLcLElecFeeChannelgRsPgRsPgR = { "map<int,JM::ElecFeeChannel,less<int>,allocator<pair<const int,JM::ElecFeeChannel> > >" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_vectorlEintcOallocatorlEintgRsPgR = { "vector<int,allocator<int> >" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_reverse_iteratorlEvectorlEintcOallocatorlEintgRsPgRcLcLiteratorgR = { "reverse_iterator<vector<int,allocator<int> >::iterator>" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_JMcLcLElecEvent = { "JM::ElecEvent" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_JMcLcLSpmtElecEvent = { "JM::SpmtElecEvent" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_vectorlEJMcLcLSpmtElecAbcBlockcOallocatorlEJMcLcLSpmtElecAbcBlockgRsPgR = { "vector<JM::SpmtElecAbcBlock,allocator<JM::SpmtElecAbcBlock> >" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_reverse_iteratorlEvectorlEJMcLcLSpmtElecAbcBlockcOallocatorlEJMcLcLSpmtElecAbcBlockgRsPgRcLcLiteratorgR = { "reverse_iterator<vector<JM::SpmtElecAbcBlock,allocator<JM::SpmtElecAbcBlock> >::iterator>" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_JMcLcLSmartRef = { "JM::SmartRef" , 99 , -1 };
G__linked_taginfo G__ElecHeaderDictLN_JMcLcLElecHeader = { "JM::ElecHeader" , 99 , -1 };

/* Reset class/struct taginfo */
extern "C" void G__cpp_reset_tagtableElecHeaderDict() {
  G__ElecHeaderDictLN_TClass.tagnum = -1 ;
  G__ElecHeaderDictLN_TBuffer.tagnum = -1 ;
  G__ElecHeaderDictLN_TMemberInspector.tagnum = -1 ;
  G__ElecHeaderDictLN_TObject.tagnum = -1 ;
  G__ElecHeaderDictLN_string.tagnum = -1 ;
  G__ElecHeaderDictLN_vectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgR.tagnum = -1 ;
  G__ElecHeaderDictLN_reverse_iteratorlEvectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgRcLcLiteratorgR.tagnum = -1 ;
  G__ElecHeaderDictLN_vectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgR.tagnum = -1 ;
  G__ElecHeaderDictLN_reverse_iteratorlEvectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgRcLcLiteratorgR.tagnum = -1 ;
  G__ElecHeaderDictLN_JM.tagnum = -1 ;
  G__ElecHeaderDictLN_JMcLcLEventObject.tagnum = -1 ;
  G__ElecHeaderDictLN_JMcLcLHeaderObject.tagnum = -1 ;
  G__ElecHeaderDictLN_maplEintcOJMcLcLElecFeeChannelcOlesslEintgRcOallocatorlEpairlEconstsPintcOJMcLcLElecFeeChannelgRsPgRsPgR.tagnum = -1 ;
  G__ElecHeaderDictLN_vectorlEintcOallocatorlEintgRsPgR.tagnum = -1 ;
  G__ElecHeaderDictLN_reverse_iteratorlEvectorlEintcOallocatorlEintgRsPgRcLcLiteratorgR.tagnum = -1 ;
  G__ElecHeaderDictLN_JMcLcLElecEvent.tagnum = -1 ;
  G__ElecHeaderDictLN_JMcLcLSpmtElecEvent.tagnum = -1 ;
  G__ElecHeaderDictLN_vectorlEJMcLcLSpmtElecAbcBlockcOallocatorlEJMcLcLSpmtElecAbcBlockgRsPgR.tagnum = -1 ;
  G__ElecHeaderDictLN_reverse_iteratorlEvectorlEJMcLcLSpmtElecAbcBlockcOallocatorlEJMcLcLSpmtElecAbcBlockgRsPgRcLcLiteratorgR.tagnum = -1 ;
  G__ElecHeaderDictLN_JMcLcLSmartRef.tagnum = -1 ;
  G__ElecHeaderDictLN_JMcLcLElecHeader.tagnum = -1 ;
}


extern "C" void G__cpp_setup_tagtableElecHeaderDict() {

   /* Setting up class,struct,union tag entry */
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_TClass);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_TBuffer);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_TMemberInspector);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_TObject);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_string);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_vectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgR);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_reverse_iteratorlEvectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgRcLcLiteratorgR);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_vectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgR);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_reverse_iteratorlEvectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgRcLcLiteratorgR);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_JM);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_JMcLcLEventObject);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_JMcLcLHeaderObject);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_maplEintcOJMcLcLElecFeeChannelcOlesslEintgRcOallocatorlEpairlEconstsPintcOJMcLcLElecFeeChannelgRsPgRsPgR);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_vectorlEintcOallocatorlEintgRsPgR);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_reverse_iteratorlEvectorlEintcOallocatorlEintgRsPgRcLcLiteratorgR);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_JMcLcLElecEvent);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_JMcLcLSpmtElecEvent);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_vectorlEJMcLcLSpmtElecAbcBlockcOallocatorlEJMcLcLSpmtElecAbcBlockgRsPgR);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_reverse_iteratorlEvectorlEJMcLcLSpmtElecAbcBlockcOallocatorlEJMcLcLSpmtElecAbcBlockgRsPgRcLcLiteratorgR);
   G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_JMcLcLSmartRef);
   G__tagtable_setup(G__get_linked_tagnum_fwd(&G__ElecHeaderDictLN_JMcLcLElecHeader),sizeof(JM::ElecHeader),-1,292096,(char*)NULL,G__setup_memvarJMcLcLElecHeader,G__setup_memfuncJMcLcLElecHeader);
}
extern "C" void G__cpp_setupElecHeaderDict(void) {
  G__check_setup_version(30051515,"G__cpp_setupElecHeaderDict()");
  G__set_cpp_environmentElecHeaderDict();
  G__cpp_setup_tagtableElecHeaderDict();

  G__cpp_setup_inheritanceElecHeaderDict();

  G__cpp_setup_typetableElecHeaderDict();

  G__cpp_setup_memvarElecHeaderDict();

  G__cpp_setup_memfuncElecHeaderDict();
  G__cpp_setup_globalElecHeaderDict();
  G__cpp_setup_funcElecHeaderDict();

   if(0==G__getsizep2memfunc()) G__get_sizep2memfuncElecHeaderDict();
  return;
}
class G__cpp_setup_initElecHeaderDict {
  public:
    G__cpp_setup_initElecHeaderDict() { G__add_setup_func("ElecHeaderDict",(G__incsetup)(&G__cpp_setupElecHeaderDict)); G__call_setup_funcs(); }
   ~G__cpp_setup_initElecHeaderDict() { G__remove_setup_func("ElecHeaderDict"); }
};
G__cpp_setup_initElecHeaderDict G__cpp_setup_initializerElecHeaderDict;

