//
// File generated by /cvmfs/juno.ihep.ac.cn/sl6_amd64_gcc447/Pre-Release/J18v1r1-Pre1/ExternalLibs/ROOT/5.34.11/bin/rootcint at Thu Dec 28 13:42:06 2017

// Do NOT change. Changes will be lost next time file is generated
//

#define R__DICTIONARY_FILENAME dOdOdIsrcdIPhyEventDict
#include "RConfig.h" //rootcint 4834
#if !defined(R__ACCESS_IN_SYMBOL)
//Break the privacy of classes -- Disabled for the moment
#define private public
#define protected public
#endif

// Since CINT ignores the std namespace, we need to do so in this file.
namespace std {} using namespace std;
#include "PhyEventDict.h"

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
   void JMcLcLPhyEvent_ShowMembers(void *obj, TMemberInspector &R__insp);
   static void *new_JMcLcLPhyEvent(void *p = 0);
   static void *newArray_JMcLcLPhyEvent(Long_t size, void *p);
   static void delete_JMcLcLPhyEvent(void *p);
   static void deleteArray_JMcLcLPhyEvent(void *p);
   static void destruct_JMcLcLPhyEvent(void *p);

   // Function generating the singleton type initializer
   static TGenericClassInfo *GenerateInitInstanceLocal(const ::JM::PhyEvent*)
   {
      ::JM::PhyEvent *ptr = 0;
      static ::TVirtualIsAProxy* isa_proxy = new ::TInstrumentedIsAProxy< ::JM::PhyEvent >(0);
      static ::ROOT::TGenericClassInfo 
         instance("JM::PhyEvent", ::JM::PhyEvent::Class_Version(), "./PhyEvent.h", 38,
                  typeid(::JM::PhyEvent), DefineBehavior(ptr, ptr),
                  &::JM::PhyEvent::Dictionary, isa_proxy, 4,
                  sizeof(::JM::PhyEvent) );
      instance.SetNew(&new_JMcLcLPhyEvent);
      instance.SetNewArray(&newArray_JMcLcLPhyEvent);
      instance.SetDelete(&delete_JMcLcLPhyEvent);
      instance.SetDeleteArray(&deleteArray_JMcLcLPhyEvent);
      instance.SetDestructor(&destruct_JMcLcLPhyEvent);
      return &instance;
   }
   TGenericClassInfo *GenerateInitInstance(const ::JM::PhyEvent*)
   {
      return GenerateInitInstanceLocal((::JM::PhyEvent*)0);
   }
   // Static variable to force the class initialization
   static ::ROOT::TGenericClassInfo *_R__UNIQUE_(Init) = GenerateInitInstanceLocal((const ::JM::PhyEvent*)0x0); R__UseDummy(_R__UNIQUE_(Init));
} // end of namespace ROOT

      namespace JM {
//______________________________________________________________________________
TClass *PhyEvent::fgIsA = 0;  // static to hold class pointer

//______________________________________________________________________________
const char *PhyEvent::Class_Name()
{
   return "JM::PhyEvent";
}

//______________________________________________________________________________
const char *PhyEvent::ImplFileName()
{
   return ::ROOT::GenerateInitInstanceLocal((const ::JM::PhyEvent*)0x0)->GetImplFileName();
}

//______________________________________________________________________________
int PhyEvent::ImplFileLine()
{
   return ::ROOT::GenerateInitInstanceLocal((const ::JM::PhyEvent*)0x0)->GetImplFileLine();
}

//______________________________________________________________________________
void PhyEvent::Dictionary()
{
   fgIsA = ::ROOT::GenerateInitInstanceLocal((const ::JM::PhyEvent*)0x0)->GetClass();
}

//______________________________________________________________________________
TClass *PhyEvent::Class()
{
   if (!fgIsA) fgIsA = ::ROOT::GenerateInitInstanceLocal((const ::JM::PhyEvent*)0x0)->GetClass();
   return fgIsA;
}

} // namespace JM
      namespace JM {
//______________________________________________________________________________
void PhyEvent::Streamer(TBuffer &R__b)
{
   // Stream an object of class JM::PhyEvent.

   if (R__b.IsReading()) {
      R__b.ReadClassBuffer(JM::PhyEvent::Class(),this);
   } else {
      R__b.WriteClassBuffer(JM::PhyEvent::Class(),this);
   }
}

} // namespace JM
//______________________________________________________________________________
      namespace JM {
void PhyEvent::ShowMembers(TMemberInspector &R__insp)
{
      // Inspect the data members of an object of class JM::PhyEvent.
      TClass *R__cl = ::JM::PhyEvent::IsA();
      if (R__cl || R__insp.IsA()) { }
      R__insp.Inspect(R__cl, R__insp.GetParent(), "m_energy", &m_energy);
      R__insp.Inspect(R__cl, R__insp.GetParent(), "m_rawEvis", &m_rawEvis);
      R__insp.Inspect(R__cl, R__insp.GetParent(), "m_enrec", &m_enrec);
      R__insp.Inspect(R__cl, R__insp.GetParent(), "m_eprec", &m_eprec);
      //This works around a msvc bug and should be harmless on other platforms
      typedef JM::EventObject baseClass1;
      baseClass1::ShowMembers(R__insp);
}

} // namespace JM
namespace ROOT {
   // Wrappers around operator new
   static void *new_JMcLcLPhyEvent(void *p) {
      return  p ? new(p) ::JM::PhyEvent : new ::JM::PhyEvent;
   }
   static void *newArray_JMcLcLPhyEvent(Long_t nElements, void *p) {
      return p ? new(p) ::JM::PhyEvent[nElements] : new ::JM::PhyEvent[nElements];
   }
   // Wrapper around operator delete
   static void delete_JMcLcLPhyEvent(void *p) {
      delete ((::JM::PhyEvent*)p);
   }
   static void deleteArray_JMcLcLPhyEvent(void *p) {
      delete [] ((::JM::PhyEvent*)p);
   }
   static void destruct_JMcLcLPhyEvent(void *p) {
      typedef ::JM::PhyEvent current_t;
      ((current_t*)p)->~current_t();
   }
} // end of namespace ROOT for class ::JM::PhyEvent

/********************************************************
* ../src/PhyEventDict.cc
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

extern "C" void G__cpp_reset_tagtablePhyEventDict();

extern "C" void G__set_cpp_environmentPhyEventDict() {
  G__add_compiledheader("TObject.h");
  G__add_compiledheader("TMemberInspector.h");
  G__add_compiledheader("PhyEvent.h");
  G__cpp_reset_tagtablePhyEventDict();
}
#include <new>
extern "C" int G__cpp_dllrevPhyEventDict() { return(30051515); }

/*********************************************************
* Member function Interface Method
*********************************************************/

/* JM::PhyEvent */
static int G__PhyEventDict_170_0_1(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
   JM::PhyEvent* p = NULL;
   char* gvp = (char*) G__getgvp();
   int n = G__getaryconstruct();
   if (n) {
     if ((gvp == (char*)G__PVOID) || (gvp == 0)) {
       p = new JM::PhyEvent[n];
     } else {
       p = new((void*) gvp) JM::PhyEvent[n];
     }
   } else {
     if ((gvp == (char*)G__PVOID) || (gvp == 0)) {
       p = new JM::PhyEvent;
     } else {
       p = new((void*) gvp) JM::PhyEvent;
     }
   }
   result7->obj.i = (long) p;
   result7->ref = (long) p;
   G__set_tagnum(result7,G__get_linked_tagnum(&G__PhyEventDictLN_JMcLcLPhyEvent));
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_2(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      {
         const Float_t& obj = ((const JM::PhyEvent*) G__getstructoffset())->energy();
         result7->ref = (long) (&obj);
         result7->obj.d = (double) (obj);
      }
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_3(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      ((JM::PhyEvent*) G__getstructoffset())->setEnergy(*(Float_t*) G__Floatref(&libp->para[0]));
      G__setnull(result7);
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_4(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      {
         const Float_t& obj = ((const JM::PhyEvent*) G__getstructoffset())->rawEvis();
         result7->ref = (long) (&obj);
         result7->obj.d = (double) (obj);
      }
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_5(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      ((JM::PhyEvent*) G__getstructoffset())->setRawEvis(*(Float_t*) G__Floatref(&libp->para[0]));
      G__setnull(result7);
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_6(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      {
         const Float_t& obj = ((const JM::PhyEvent*) G__getstructoffset())->enrec();
         result7->ref = (long) (&obj);
         result7->obj.d = (double) (obj);
      }
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_7(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      ((JM::PhyEvent*) G__getstructoffset())->setEnrec(*(Float_t*) G__Floatref(&libp->para[0]));
      G__setnull(result7);
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_8(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      {
         const Float_t& obj = ((const JM::PhyEvent*) G__getstructoffset())->eprec();
         result7->ref = (long) (&obj);
         result7->obj.d = (double) (obj);
      }
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_9(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      ((JM::PhyEvent*) G__getstructoffset())->setEprec(*(Float_t*) G__Floatref(&libp->para[0]));
      G__setnull(result7);
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_10(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 85, (long) JM::PhyEvent::Class());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_11(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 67, (long) JM::PhyEvent::Class_Name());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_12(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 115, (long) JM::PhyEvent::Class_Version());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_13(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      JM::PhyEvent::Dictionary();
      G__setnull(result7);
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_17(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      ((JM::PhyEvent*) G__getstructoffset())->StreamerNVirtual(*(TBuffer*) libp->para[0].ref);
      G__setnull(result7);
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_18(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 67, (long) JM::PhyEvent::DeclFileName());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_19(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 105, (long) JM::PhyEvent::ImplFileLine());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_20(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 67, (long) JM::PhyEvent::ImplFileName());
   return(1 || funcname || hash || result7 || libp) ;
}

static int G__PhyEventDict_170_0_21(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
      G__letint(result7, 105, (long) JM::PhyEvent::DeclFileLine());
   return(1 || funcname || hash || result7 || libp) ;
}

// automatic copy constructor
static int G__PhyEventDict_170_0_22(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)

{
   JM::PhyEvent* p;
   void* tmp = (void*) G__int(libp->para[0]);
   p = new JM::PhyEvent(*(JM::PhyEvent*) tmp);
   result7->obj.i = (long) p;
   result7->ref = (long) p;
   G__set_tagnum(result7,G__get_linked_tagnum(&G__PhyEventDictLN_JMcLcLPhyEvent));
   return(1 || funcname || hash || result7 || libp) ;
}

// automatic destructor
typedef JM::PhyEvent G__TJMcLcLPhyEvent;
static int G__PhyEventDict_170_0_23(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
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
       delete[] (JM::PhyEvent*) soff;
     } else {
       G__setgvp((long) G__PVOID);
       for (int i = n - 1; i >= 0; --i) {
         ((JM::PhyEvent*) (soff+(sizeof(JM::PhyEvent)*i)))->~G__TJMcLcLPhyEvent();
       }
       G__setgvp((long)gvp);
     }
   } else {
     if (gvp == (char*)G__PVOID) {
       delete (JM::PhyEvent*) soff;
     } else {
       G__setgvp((long) G__PVOID);
       ((JM::PhyEvent*) (soff))->~G__TJMcLcLPhyEvent();
       G__setgvp((long)gvp);
     }
   }
   G__setnull(result7);
   return(1 || funcname || hash || result7 || libp) ;
}

// automatic assignment operator
static int G__PhyEventDict_170_0_24(G__value* result7, G__CONST char* funcname, struct G__param* libp, int hash)
{
   JM::PhyEvent* dest = (JM::PhyEvent*) G__getstructoffset();
   *dest = *(JM::PhyEvent*) libp->para[0].ref;
   const JM::PhyEvent& obj = *dest;
   result7->ref = (long) (&obj);
   result7->obj.i = (long) (&obj);
   return(1 || funcname || hash || result7 || libp) ;
}


/* Setting up global function */

/*********************************************************
* Member function Stub
*********************************************************/

/* JM::PhyEvent */

/*********************************************************
* Global function Stub
*********************************************************/

/*********************************************************
* Get size of pointer to member function
*********************************************************/
class G__Sizep2memfuncPhyEventDict {
 public:
  G__Sizep2memfuncPhyEventDict(): p(&G__Sizep2memfuncPhyEventDict::sizep2memfunc) {}
    size_t sizep2memfunc() { return(sizeof(p)); }
  private:
    size_t (G__Sizep2memfuncPhyEventDict::*p)();
};

size_t G__get_sizep2memfuncPhyEventDict()
{
  G__Sizep2memfuncPhyEventDict a;
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
extern "C" void G__cpp_setup_inheritancePhyEventDict() {

   /* Setting up class inheritance */
   if(0==G__getnumbaseclass(G__get_linked_tagnum(&G__PhyEventDictLN_JMcLcLPhyEvent))) {
     JM::PhyEvent *G__Lderived;
     G__Lderived=(JM::PhyEvent*)0x1000;
     {
       JM::EventObject *G__Lpbase=(JM::EventObject*)G__Lderived;
       G__inheritance_setup(G__get_linked_tagnum(&G__PhyEventDictLN_JMcLcLPhyEvent),G__get_linked_tagnum(&G__PhyEventDictLN_JMcLcLEventObject),(long)G__Lpbase-(long)G__Lderived,1,1);
     }
     {
       TObject *G__Lpbase=(TObject*)G__Lderived;
       G__inheritance_setup(G__get_linked_tagnum(&G__PhyEventDictLN_JMcLcLPhyEvent),G__get_linked_tagnum(&G__PhyEventDictLN_TObject),(long)G__Lpbase-(long)G__Lderived,1,0);
     }
   }
}

/*********************************************************
* typedef information setup/
*********************************************************/
extern "C" void G__cpp_setup_typetablePhyEventDict() {

   /* Setting up typedef entry */
   G__search_typename2("Float_t",102,-1,0,-1);
   G__setnewtype(-1,"Float 4 bytes (float)",0);
   G__search_typename2("Version_t",115,-1,0,-1);
   G__setnewtype(-1,"Class version identifier (short)",0);
   G__search_typename2("vector<ROOT::TSchemaHelper>",117,G__get_linked_tagnum(&G__PhyEventDictLN_vectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgR),0,-1);
   G__setnewtype(-1,NULL,0);
   G__search_typename2("reverse_iterator<const_iterator>",117,G__get_linked_tagnum(&G__PhyEventDictLN_reverse_iteratorlEvectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgRcLcLiteratorgR),0,G__get_linked_tagnum(&G__PhyEventDictLN_vectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgR));
   G__setnewtype(-1,NULL,0);
   G__search_typename2("reverse_iterator<iterator>",117,G__get_linked_tagnum(&G__PhyEventDictLN_reverse_iteratorlEvectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgRcLcLiteratorgR),0,G__get_linked_tagnum(&G__PhyEventDictLN_vectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgR));
   G__setnewtype(-1,NULL,0);
   G__search_typename2("vector<TVirtualArray*>",117,G__get_linked_tagnum(&G__PhyEventDictLN_vectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgR),0,-1);
   G__setnewtype(-1,NULL,0);
   G__search_typename2("reverse_iterator<const_iterator>",117,G__get_linked_tagnum(&G__PhyEventDictLN_reverse_iteratorlEvectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgRcLcLiteratorgR),0,G__get_linked_tagnum(&G__PhyEventDictLN_vectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgR));
   G__setnewtype(-1,NULL,0);
   G__search_typename2("reverse_iterator<iterator>",117,G__get_linked_tagnum(&G__PhyEventDictLN_reverse_iteratorlEvectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgRcLcLiteratorgR),0,G__get_linked_tagnum(&G__PhyEventDictLN_vectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgR));
   G__setnewtype(-1,NULL,0);
}

/*********************************************************
* Data Member information setup/
*********************************************************/

   /* Setting up class,struct,union tag member variable */

   /* JM::PhyEvent */
static void G__setup_memvarJMcLcLPhyEvent(void) {
   G__tag_memvar_setup(G__get_linked_tagnum(&G__PhyEventDictLN_JMcLcLPhyEvent));
   { JM::PhyEvent *p; p=(JM::PhyEvent*)0x1000; if (p) { }
   G__memvar_setup((void*)0,102,0,0,-1,G__defined_typename("Float_t"),-1,4,"m_energy=",0,(char*)NULL);
   G__memvar_setup((void*)0,102,0,0,-1,G__defined_typename("Float_t"),-1,4,"m_rawEvis=",0,(char*)NULL);
   G__memvar_setup((void*)0,102,0,0,-1,G__defined_typename("Float_t"),-1,4,"m_enrec=",0,(char*)NULL);
   G__memvar_setup((void*)0,102,0,0,-1,G__defined_typename("Float_t"),-1,4,"m_eprec=",0,(char*)NULL);
   G__memvar_setup((void*)0,85,0,0,G__get_linked_tagnum(&G__PhyEventDictLN_TClass),-1,-2,4,"fgIsA=",0,(char*)NULL);
   }
   G__tag_memvar_reset();
}

extern "C" void G__cpp_setup_memvarPhyEventDict() {
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
static void G__setup_memfuncJMcLcLPhyEvent(void) {
   /* JM::PhyEvent */
   G__tag_memfunc_setup(G__get_linked_tagnum(&G__PhyEventDictLN_JMcLcLPhyEvent));
   G__memfunc_setup("PhyEvent",819,G__PhyEventDict_170_0_1, 105, G__get_linked_tagnum(&G__PhyEventDictLN_JMcLcLPhyEvent), -1, 0, 0, 1, 1, 0, "", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("energy",650,G__PhyEventDict_170_0_2, 102, -1, G__defined_typename("Float_t"), 1, 0, 1, 1, 9, "", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("setEnergy",950,G__PhyEventDict_170_0_3, 121, -1, -1, 0, 1, 1, 1, 0, "f - 'Float_t' 11 - value", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("rawEvis",737,G__PhyEventDict_170_0_4, 102, -1, G__defined_typename("Float_t"), 1, 0, 1, 1, 9, "", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("setRawEvis",1037,G__PhyEventDict_170_0_5, 121, -1, -1, 0, 1, 1, 1, 0, "f - 'Float_t' 11 - value", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("enrec",525,G__PhyEventDict_170_0_6, 102, -1, G__defined_typename("Float_t"), 1, 0, 1, 1, 9, "", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("setEnrec",825,G__PhyEventDict_170_0_7, 121, -1, -1, 0, 1, 1, 1, 0, "f - 'Float_t' 11 - value", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("eprec",527,G__PhyEventDict_170_0_8, 102, -1, G__defined_typename("Float_t"), 1, 0, 1, 1, 9, "", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("setEprec",827,G__PhyEventDict_170_0_9, 121, -1, -1, 0, 1, 1, 1, 0, "f - 'Float_t' 11 - value", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("Class",502,G__PhyEventDict_170_0_10, 85, G__get_linked_tagnum(&G__PhyEventDictLN_TClass), -1, 0, 0, 3, 1, 0, "", (char*)NULL, (void*) G__func2void( (TClass* (*)())(&JM::PhyEvent::Class) ), 0);
   G__memfunc_setup("Class_Name",982,G__PhyEventDict_170_0_11, 67, -1, -1, 0, 0, 3, 1, 1, "", (char*)NULL, (void*) G__func2void( (const char* (*)())(&JM::PhyEvent::Class_Name) ), 0);
   G__memfunc_setup("Class_Version",1339,G__PhyEventDict_170_0_12, 115, -1, G__defined_typename("Version_t"), 0, 0, 3, 1, 0, "", (char*)NULL, (void*) G__func2void( (Version_t (*)())(&JM::PhyEvent::Class_Version) ), 0);
   G__memfunc_setup("Dictionary",1046,G__PhyEventDict_170_0_13, 121, -1, -1, 0, 0, 3, 1, 0, "", (char*)NULL, (void*) G__func2void( (void (*)())(&JM::PhyEvent::Dictionary) ), 0);
   G__memfunc_setup("IsA",253,(G__InterfaceMethod) NULL,85, G__get_linked_tagnum(&G__PhyEventDictLN_TClass), -1, 0, 0, 1, 1, 8, "", (char*)NULL, (void*) NULL, 1);
   G__memfunc_setup("ShowMembers",1132,(G__InterfaceMethod) NULL,121, -1, -1, 0, 1, 1, 1, 0, "u 'TMemberInspector' - 1 - -", (char*)NULL, (void*) NULL, 1);
   G__memfunc_setup("Streamer",835,(G__InterfaceMethod) NULL,121, -1, -1, 0, 1, 1, 1, 0, "u 'TBuffer' - 1 - -", (char*)NULL, (void*) NULL, 1);
   G__memfunc_setup("StreamerNVirtual",1656,G__PhyEventDict_170_0_17, 121, -1, -1, 0, 1, 1, 1, 0, "u 'TBuffer' - 1 - ClassDef_StreamerNVirtual_b", (char*)NULL, (void*) NULL, 0);
   G__memfunc_setup("DeclFileName",1145,G__PhyEventDict_170_0_18, 67, -1, -1, 0, 0, 3, 1, 1, "", (char*)NULL, (void*) G__func2void( (const char* (*)())(&JM::PhyEvent::DeclFileName) ), 0);
   G__memfunc_setup("ImplFileLine",1178,G__PhyEventDict_170_0_19, 105, -1, -1, 0, 0, 3, 1, 0, "", (char*)NULL, (void*) G__func2void( (int (*)())(&JM::PhyEvent::ImplFileLine) ), 0);
   G__memfunc_setup("ImplFileName",1171,G__PhyEventDict_170_0_20, 67, -1, -1, 0, 0, 3, 1, 1, "", (char*)NULL, (void*) G__func2void( (const char* (*)())(&JM::PhyEvent::ImplFileName) ), 0);
   G__memfunc_setup("DeclFileLine",1152,G__PhyEventDict_170_0_21, 105, -1, -1, 0, 0, 3, 1, 0, "", (char*)NULL, (void*) G__func2void( (int (*)())(&JM::PhyEvent::DeclFileLine) ), 0);
   // automatic copy constructor
   G__memfunc_setup("PhyEvent", 819, G__PhyEventDict_170_0_22, (int) ('i'), G__get_linked_tagnum(&G__PhyEventDictLN_JMcLcLPhyEvent), -1, 0, 1, 1, 1, 0, "u 'JM::PhyEvent' - 11 - -", (char*) NULL, (void*) NULL, 0);
   // automatic destructor
   G__memfunc_setup("~PhyEvent", 945, G__PhyEventDict_170_0_23, (int) ('y'), -1, -1, 0, 0, 1, 1, 0, "", (char*) NULL, (void*) NULL, 1);
   // automatic assignment operator
   G__memfunc_setup("operator=", 937, G__PhyEventDict_170_0_24, (int) ('u'), G__get_linked_tagnum(&G__PhyEventDictLN_JMcLcLPhyEvent), -1, 1, 1, 1, 1, 0, "u 'JM::PhyEvent' - 11 - -", (char*) NULL, (void*) NULL, 0);
   G__tag_memfunc_reset();
}


/*********************************************************
* Member function information setup
*********************************************************/
extern "C" void G__cpp_setup_memfuncPhyEventDict() {
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
extern "C" void G__cpp_setup_globalPhyEventDict() {
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

   G__resetifuncposition();
}

extern "C" void G__cpp_setup_funcPhyEventDict() {
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
}

/*********************************************************
* Class,struct,union,enum tag information setup
*********************************************************/
/* Setup class/struct taginfo */
G__linked_taginfo G__PhyEventDictLN_TClass = { "TClass" , 99 , -1 };
G__linked_taginfo G__PhyEventDictLN_TBuffer = { "TBuffer" , 99 , -1 };
G__linked_taginfo G__PhyEventDictLN_TMemberInspector = { "TMemberInspector" , 99 , -1 };
G__linked_taginfo G__PhyEventDictLN_TObject = { "TObject" , 99 , -1 };
G__linked_taginfo G__PhyEventDictLN_vectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgR = { "vector<ROOT::TSchemaHelper,allocator<ROOT::TSchemaHelper> >" , 99 , -1 };
G__linked_taginfo G__PhyEventDictLN_reverse_iteratorlEvectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgRcLcLiteratorgR = { "reverse_iterator<vector<ROOT::TSchemaHelper,allocator<ROOT::TSchemaHelper> >::iterator>" , 99 , -1 };
G__linked_taginfo G__PhyEventDictLN_vectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgR = { "vector<TVirtualArray*,allocator<TVirtualArray*> >" , 99 , -1 };
G__linked_taginfo G__PhyEventDictLN_reverse_iteratorlEvectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgRcLcLiteratorgR = { "reverse_iterator<vector<TVirtualArray*,allocator<TVirtualArray*> >::iterator>" , 99 , -1 };
G__linked_taginfo G__PhyEventDictLN_JM = { "JM" , 110 , -1 };
G__linked_taginfo G__PhyEventDictLN_JMcLcLEventObject = { "JM::EventObject" , 99 , -1 };
G__linked_taginfo G__PhyEventDictLN_JMcLcLPhyEvent = { "JM::PhyEvent" , 99 , -1 };

/* Reset class/struct taginfo */
extern "C" void G__cpp_reset_tagtablePhyEventDict() {
  G__PhyEventDictLN_TClass.tagnum = -1 ;
  G__PhyEventDictLN_TBuffer.tagnum = -1 ;
  G__PhyEventDictLN_TMemberInspector.tagnum = -1 ;
  G__PhyEventDictLN_TObject.tagnum = -1 ;
  G__PhyEventDictLN_vectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgR.tagnum = -1 ;
  G__PhyEventDictLN_reverse_iteratorlEvectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgRcLcLiteratorgR.tagnum = -1 ;
  G__PhyEventDictLN_vectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgR.tagnum = -1 ;
  G__PhyEventDictLN_reverse_iteratorlEvectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgRcLcLiteratorgR.tagnum = -1 ;
  G__PhyEventDictLN_JM.tagnum = -1 ;
  G__PhyEventDictLN_JMcLcLEventObject.tagnum = -1 ;
  G__PhyEventDictLN_JMcLcLPhyEvent.tagnum = -1 ;
}


extern "C" void G__cpp_setup_tagtablePhyEventDict() {

   /* Setting up class,struct,union tag entry */
   G__get_linked_tagnum_fwd(&G__PhyEventDictLN_TClass);
   G__get_linked_tagnum_fwd(&G__PhyEventDictLN_TBuffer);
   G__get_linked_tagnum_fwd(&G__PhyEventDictLN_TMemberInspector);
   G__get_linked_tagnum_fwd(&G__PhyEventDictLN_TObject);
   G__get_linked_tagnum_fwd(&G__PhyEventDictLN_vectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgR);
   G__get_linked_tagnum_fwd(&G__PhyEventDictLN_reverse_iteratorlEvectorlEROOTcLcLTSchemaHelpercOallocatorlEROOTcLcLTSchemaHelpergRsPgRcLcLiteratorgR);
   G__get_linked_tagnum_fwd(&G__PhyEventDictLN_vectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgR);
   G__get_linked_tagnum_fwd(&G__PhyEventDictLN_reverse_iteratorlEvectorlETVirtualArraymUcOallocatorlETVirtualArraymUgRsPgRcLcLiteratorgR);
   G__get_linked_tagnum_fwd(&G__PhyEventDictLN_JM);
   G__get_linked_tagnum_fwd(&G__PhyEventDictLN_JMcLcLEventObject);
   G__tagtable_setup(G__get_linked_tagnum_fwd(&G__PhyEventDictLN_JMcLcLPhyEvent),sizeof(JM::PhyEvent),-1,292096,(char*)NULL,G__setup_memvarJMcLcLPhyEvent,G__setup_memfuncJMcLcLPhyEvent);
}
extern "C" void G__cpp_setupPhyEventDict(void) {
  G__check_setup_version(30051515,"G__cpp_setupPhyEventDict()");
  G__set_cpp_environmentPhyEventDict();
  G__cpp_setup_tagtablePhyEventDict();

  G__cpp_setup_inheritancePhyEventDict();

  G__cpp_setup_typetablePhyEventDict();

  G__cpp_setup_memvarPhyEventDict();

  G__cpp_setup_memfuncPhyEventDict();
  G__cpp_setup_globalPhyEventDict();
  G__cpp_setup_funcPhyEventDict();

   if(0==G__getsizep2memfunc()) G__get_sizep2memfuncPhyEventDict();
  return;
}
class G__cpp_setup_initPhyEventDict {
  public:
    G__cpp_setup_initPhyEventDict() { G__add_setup_func("PhyEventDict",(G__incsetup)(&G__cpp_setupPhyEventDict)); G__call_setup_funcs(); }
   ~G__cpp_setup_initPhyEventDict() { G__remove_setup_func("PhyEventDict"); }
};
G__cpp_setup_initPhyEventDict G__cpp_setup_initializerPhyEventDict;

